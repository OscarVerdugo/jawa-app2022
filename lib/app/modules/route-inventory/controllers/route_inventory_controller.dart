import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/models/product/inventory_product_model.dart';
import 'package:jawa_app/app/models/product/product_model.dart';
import 'package:jawa_app/app/models/product/product_refill_model.dart';
import 'package:jawa_app/app/modules/route-inventory/widgets/inventory_menu.dart';
import 'package:jawa_app/app/routes/app_pages.dart';
import 'package:jawa_app/app/services/general_service.dart';
import 'package:jawa_app/app/services/inventory_service.dart';
import 'package:jawa_app/app/utils/constants.dart';
import 'package:jawa_app/app/utils/ui/services/alert_ui_service.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

import '../../../utils/utils.dart';

class RouteInventoryController extends GetxController {
  final hasConnection = RxBool(false);
  final intentoryLoading = RxBool(false);
  final refillsLoading = RxBool(false);
  final respondRefillsLoading = RxBool(false);
  final saveRequestsLoading = RxBool(false);
  final productsLoading = RxBool(false);

  final loadingMessage = RxnString();

  final inventoryService = InventoryService();
  final generalService = GeneralService();

  final toastService = UIToastService();

  final storage = FlutterSecureStorage();

  final globalController = Get.find<GlobalController>();
  final inventory = RxList<InventoryProductModel>();
  final refills = RxList<ProductRefillModel>();
  final products = RxList<ProductModel>();

  @override
  void onInit() async {
    super.onInit();
    Connection connection = Connection.getInstance();
    connection.onConnectionChange.listen(onChangeConnection);
    hasConnection.value = await connection.checkConnection();
    getInventory();
  }

  Future<void> getInventory() async {
    intentoryLoading.value = true;
    loadingMessage.value = "Obteniendo inventario...";
    update();
    if (hasConnection.value) {
      final res = await inventoryService.getInventory(
          routeId: globalController.route.value!.idRuta!);
      if (res.success && res.data != null) {
        inventory.value = res.data!;
        await storage.write(
            key: "route-inventory", value: jsonEncode(res.data!));
      } else {
        print("RESULT FAILURE");
      }
    } else {
      await getCachedInventory();
    }
    intentoryLoading.value = false;
    loadingMessage.value = null;
    update();
  }

  Future<void> getCachedInventory() async {
    final storedInventory = await storage.read(key: "route-inventory");
    if (storedInventory != null) {
      inventory.value = List<InventoryProductModel>.from(
          jsonDecode(storedInventory)
              .map((x) => InventoryProductModel.fromJson(x)));
    }
  }

  Future<void> getRefills() async {
    refillsLoading.value = true;
    loadingMessage.value = "Obteniendo recargas...";
    update();
    if (hasConnection.value) {
      final res = await inventoryService.getRefills(
          routeId: globalController.route.value!.idRuta!);
      if (res.success && res.data != null) {
        refills.value = res.data!;
        storage.write(key: "route-refills", value: jsonEncode(res.data!));
      } else {
        print("RESULT FAILURE");
      }
    } else {
      getCachedRefills();
    }
    refillsLoading.value = false;
    loadingMessage.value = null;
    sortRefills();
    update();
  }

  Future<void> getCachedRefills() async {
    final storedInventory = await storage.read(key: "route-refills");
    if (storedInventory != null) {
      refills.value = List<ProductRefillModel>.from(jsonDecode(storedInventory)
          .map((x) => ProductRefillModel.fromJson(x)));
    }
  }

  Future<void> getProducts() async {
    products.value = [];
    productsLoading.value = true;
    update();
    loadingMessage.value = "Obteniendo productos...";
    if (hasConnection.value) {
      final res = await generalService.getProducts();
      if (res.success && res.data != null) {
        products.value = res.data!;

        for (var p in products) {
          final i =
              inventory.indexWhere((i) => i.idPresentacion == p.idPresentacion);
          if (i != -1) {
            p.disponible = inventory[i].disponible;
          }
        }

        await storage.write(
            key: "route-products", value: jsonEncode(res.data!));
      } else {
        print("RESULT FAILURE");
      }
    } else {
      await getCachedProducts();
    }
    productsLoading.value = false;
    loadingMessage.value = null;
    update();
  }

  Future<void> getCachedProducts() async {
    final storedProducts = await storage.read(key: "route-products");
    if (storedProducts != null) {
      products.value = List<ProductModel>.from(
          jsonDecode(storedProducts).map((x) => ProductModel.fromJson(x)));
    }
  }

  sortRefills() {
    refills.sort(((a, b) {
      if (a.estatus == STATUS.PENDING && a.origen == REFILL_ORIGIN.BRANCH) {
        return 0;
      } else {
        return 1;
      }
    }));
  }

  handleAnswerRefill(ProductRefillModel refill, bool? answer) {
    refill.aceptado = answer;
    update();
  }

  handleSaveRefills() {
    if (refills
        .where((r) =>
            r.aceptado == null &&
            r.estatus == STATUS.PENDING &&
            r.origen == REFILL_ORIGIN.BRANCH)
        .isNotEmpty) {
      toastService.error(message: "Te quedan recargas por aceptar o rechazar!");
    } else {
      UIAlertService.showConfirm(Get.context!,
          title: "Enviar", message: "Está seguro de continuar?", onAccept: () {
        saveRefills();
      });
    }
  }

  saveRefills() async {
    respondRefillsLoading.value = true;
    update();
    if (hasConnection.isTrue) {
      final responses = refills
          .where((r) =>
              r.aceptado != null &&
              r.estatus == STATUS.PENDING &&
              r.origen == REFILL_ORIGIN.BRANCH)
          .map((e) => e.toRefillResponse())
          .toList();
      final res = await inventoryService.respondToRefill(responses: responses);
      if (res.success) {
        toastService.success(message: "Recargas respondidas con éxito!");
        updateRefills();
        getInventory();
      }
    } else {
      toastService.error(
          message: "Se requiere de una conexión a internet estable");
    }
    respondRefillsLoading.value = false;
    update();
  }

  updateRefills() async {
    for (var ref in refills) {
      if (ref.aceptado == null) continue;
      ref.estatus = ref.aceptado == true ? STATUS.ACTIVE : STATUS.REJECTED;
      ref.aceptado = null;
    }
    refills.refresh();
    await storage.write(key: "route-refills", value: jsonEncode(refills));
  }

  handleOpenMenu() {
    showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return InventoryMenu();
        });
  }

  handleGoToRefills() {
    Get.back();
    Get.toNamed(Routes.ROUTE_REFILLS);
    getRefills();
  }

  handleGoToRequest() {
    Get.back();
    Get.toNamed(Routes.ROUTE_REQUEST_REFILLS);
    getProducts();
  }

  handleGoToRequestReturn() {
    Get.back();
    Get.toNamed(Routes.ROUTE_REQUEST_REFILLS, arguments: {"isReturn": true});
    getProducts();
  }

  handleRequestProductQuantity(ProductModel product, bool isReturn) async {
    final newQuantity = await UIQuantityBottomSheetService.request(Get.context!,
        initial: product.cantidad);
    if (isReturn && newQuantity != null && newQuantity > product.disponible) {
      product.cantidad = null;
      toastService.error(
          message: "No puede retornar mas producto del disponible.");
    } else {
      product.cantidad = newQuantity;
    }
    update();
  }

  handleSaveRequests({bool isReturn = false}) {
    UIAlertService.showConfirm(Get.context!,
        title: "Enviar", message: "Está seguro de continuar?", onAccept: () {
      saveRequests(isReturn);
    });
  }

  saveRequests(bool isReturn) async {
    saveRequestsLoading.value = true;
    update();
    if (hasConnection.isTrue) {
      final responses = products
          .where((p) => p.cantidad != null)
          .map((e) => isReturn
              ? e.toReturn(globalController.route.value!.idRuta!)
              : e.toRequest(globalController.route.value!.idRuta!))
          .toList();
      print(responses);

      final res = await inventoryService.requestProducts(responses: responses);
      if (res.success) {
        toastService.success(message: "Solicitudes enviadas con éxito!");
        Get.back();
        handleGoToRefills();
      }
    } else {
      toastService.error(
          message: "Se requiere de una conexión a internet estable");
    }
    saveRequestsLoading.value = false;
    update();
  }

  @override
  void onClose() {}

  void onChangeConnection(bool hasConnection) {
    this.hasConnection.value = hasConnection;
    if (!hasConnection) {
      // displayMessage.value = true;
      // message.value = "Necesitas conexión a internet para iniciar";
    } else {
      // displayMessage.value = false;
      // message.value = null;
    }
  }
}
