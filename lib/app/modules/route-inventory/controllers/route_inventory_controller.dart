import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/models/product/inventory_product_model.dart';
import 'package:jawa_app/app/models/product/product_refill_model.dart';
import 'package:jawa_app/app/modules/route-inventory/widgets/inventory_menu.dart';
import 'package:jawa_app/app/routes/app_pages.dart';
import 'package:jawa_app/app/services/inventory_service.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

import '../../../utils/utils.dart';

class RouteInventoryController extends GetxController {
  final hasConnection = RxBool(false);
  final intentoryLoading = RxBool(false);
  final refillsLoading = RxBool(false);

  final inventoryService = InventoryService();
  final toastService = UIToastService();

  final storage = FlutterSecureStorage();

  final globalController = Get.find<GlobalController>();
  final products = RxList<InventoryProductModel>();
  final refills = RxList<ProductRefillModel>();

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
    if (hasConnection.value) {
      final res = await inventoryService.getInventory(
          routeId: globalController.route.value!.idRuta!);
      if (res.success && res.data != null) {
        products.value = res.data!;
        await storage.write(
            key: "route-inventory", value: jsonEncode(res.data!));
      } else {
        print("RESULT FAILURE");
      }
    } else {
      await getCachedInventory();
    }
    intentoryLoading.value = false;
    update();
  }

  Future<void> getCachedInventory() async {
    final storedInventory = await storage.read(key: "route-inventory");
    if (storedInventory != null) {
      products.value = List<InventoryProductModel>.from(
          jsonDecode(storedInventory)
              .map((x) => InventoryProductModel.fromJson(x)));
    }
  }

  Future<void> getRefills() async {
    refillsLoading.value = true;
    if (hasConnection.value) {
      final res = await inventoryService.getRefills(
          routeId: globalController.route.value!.idRuta!);
      if (res.success && res.data != null) {
        refills.value = res.data!;
        await storage.write(key: "route-refills", value: jsonEncode(res.data!));
      } else {
        print("RESULT FAILURE");
      }
      refillsLoading.value = false;
    } else {
      await getCachedRefills();
    }
    sortRefills();
    update();
  }

  Future<void> getCachedRefills() async {
    final storedInventory = await storage.read(key: "route-inventory");
    if (storedInventory != null) {
      products.value = List<InventoryProductModel>.from(
          jsonDecode(storedInventory)
              .map((x) => InventoryProductModel.fromJson(x)));
    }
  }

  sortRefills() {
    refills.sort(((a, b) {
      if (a.estatus == "PEN" && a.origen == "SUC") {
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
    toastService.error(
        message:
            "Este es un mensaje de prueba muy largo, necesito ser aun mas largo");
    toastService.success(message: "Error de prueba");
    toastService.warning(message: "Error de prueba");
    toastService.info(message: "Error de prueba");
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
