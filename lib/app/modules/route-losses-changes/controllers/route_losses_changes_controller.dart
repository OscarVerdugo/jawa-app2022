import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/models/product/product_movement_model.dart';
import 'package:jawa_app/app/models/route/route_customer_model.dart';
import 'package:jawa_app/app/routes/app_pages.dart';

import '../../../controllers/global_controller.dart';
import '../../../models/product/inventory_product_model.dart';
import '../../../models/product/product_model.dart';
import '../../../services/general_service.dart';
import '../../../services/inventory_service.dart';
import '../../../utils/ui/ui.dart';
import '../../../utils/utils.dart';

class RouteLossesChangesController extends GetxController {
  late String type;
  late RouteCustomerModel customer;

  final hasConnection = RxBool(false);
  final inventoryLoading = RxBool(false);
  final productsLoading = RxBool(false);
  final loadingMessage = RxnString();

  final inventoryService = InventoryService();
  final generalService = GeneralService();
  final storage = FlutterSecureStorage();
  final toastService = UIToastService();

  List<InventoryProductModel> inventory = List.empty();
  final products = RxList<ProductModel>();
  final availableProducts = RxList<ProductModel>();

  final movements = RxList<ProductMovementModel>();

  final globalController = Get.find<GlobalController>();

  final RxnInt toReceive = RxnInt(null);
  final Rxn<ProductModel> selectedProduct = Rxn<ProductModel>(null);

  @override
  void onInit() async {
    type = Get.arguments["type"];
    customer = Get.arguments["customer"];
    Connection connection = Connection.getInstance();
    connection.onConnectionChange.listen(onChangeConnection);
    hasConnection.value = await connection.checkConnection();

    super.onInit();
    await getInventory();
    await getProducts();
  }

  Future<void> getInventory() async {
    inventoryLoading.value = true;
    loadingMessage.value = "Obteniendo inventario...";
    update();
    if (hasConnection.value) {
      final res = await inventoryService.getInventory(
          routeId: globalController.route.value!.idRuta!);
      if (res.success && res.data != null) {
        inventory = res.data!;
        await storage.write(
            key: "route-inventory", value: jsonEncode(res.data!));
      } else {
        print("RESULT FAILURE");
      }
    } else {
      await getCachedInventory();
    }
    inventoryLoading.value = false;
    loadingMessage.value = null;
    update();
  }

  Future<void> getCachedInventory() async {
    final storedInventory = await storage.read(key: "route-inventory");
    if (storedInventory != null) {
      inventory = List<InventoryProductModel>.from(jsonDecode(storedInventory)
          .map((x) => InventoryProductModel.fromJson(x)));
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

        Utils.pairWithInventory(products, inventory);
        Utils.pairWithPrices(
            products: products,
            idPriceGroup: customer.idGrupoPrecios,
            groups: globalController.route.value!.gruposPrecios);

        availableProducts.value =
            products.where((p) => p.disponible > 0).toList();
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

  @override
  void onReady() {
    super.onReady();
    handleChooseToReceive();
  }

  handleChooseToReceive() {
    Get.toNamed(Routes.ROUTE_LOSSES_CHANGES_TO_RECEIVE);
  }

  handleSelectToReceive(ProductModel product) async {
    final quantity = await UIQuantityBottomSheetService.request(Get.context!);
    if (quantity != null) {
      selectedProduct.value = product;
      toReceive.value = quantity;
      for (var p in availableProducts) {
        p.cantidad = null;
      }
      Get.offNamed(Routes.ROUTE_LOSSES_CHANGES_TO_GIVE);
    } else {
      selectedProduct.value = null;
    }
  }

  handleSelectToGive(int index) async {
    final quantity = await UIQuantityBottomSheetService.request(Get.context!,
        initial: availableProducts[index].cantidad);
    final alreadySelected =
        availableProducts.fold<int>(0, (sum, p) => (p.cantidad ?? 0) + sum);
    if (quantity != null) {
      if (alreadySelected + quantity > toReceive.value!) {
        toastService.error(
            message: "No se puede dar más producto del que se va a recibir.");
        availableProducts[index].cantidad = null;
      } else {
        availableProducts[index].cantidad = quantity;
      }
    } else {
      availableProducts[index].cantidad = null;
    }
    update();
  }

  handleRegistMovement() {
    final newMovements = availableProducts
        .where((p) => p.cantidad != null && p.cantidad! > 0)
        .toList()
        .map((p) => ProductMovementModel.fromLossChange(
            idRoute: globalController.route.value!.idRuta!,
            idRouteCustomer: customer.idRutaCliente,
            product: p,
            toReceive: selectedProduct.value!,
            type: type));

    movements.addAll(newMovements);

    for (var p in availableProducts) {
      p.cantidad = null;
    }
    update();
    Get.back();
    toReceive.value = null;
    selectedProduct.value = null;
  }

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

  @override
  void onClose() {}
}
