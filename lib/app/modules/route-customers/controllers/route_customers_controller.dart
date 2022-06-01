import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/models/route/route_customer_model.dart';
import 'package:jawa_app/app/modules/route-customers/widgets/customer_menu.dart';
import 'package:jawa_app/app/services/route_service.dart';

import '../../../utils/utils.dart';

class RouteCustomersController extends GetxController {
  final storage = FlutterSecureStorage();

  final globalController = Get.find<GlobalController>();
  final routeService = RouteService();
  final customers = RxList<RouteCustomerModel>();

  final loading = RxBool(true);

  final hasConnection = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    Connection connection = Connection.getInstance();
    connection.onConnectionChange.listen(onChangeConnection);
    hasConnection.value = await connection.checkConnection();

    loadCustomers();
  }

  loadCustomers() async {
    loading.value = true;
    if (hasConnection.value) {
      final res = await routeService.getRouteCustomers(
          routeId: globalController.route.value!.idRuta!);
      if (res.success && res.data != null) {
        customers.value = res.data!;
        await cacheCustomers();
      } else {
        print("RESULT FAILURE");
      }
    } else {
      await getCachedCustomers();
    }
    sortCustomers();
    loading.value = false;
    update();
  }

  getCachedCustomers() async {
    final storedCustomers = await storage.read(key: "route-customers");
    if (storedCustomers != null) {
      customers.value = List<RouteCustomerModel>.from(
          jsonDecode(storedCustomers)
              .map((x) => RouteCustomerModel.fromMap(x)));
    }
  }

  sortCustomers() {
    customers.sort(((a, b) {
      if (a.horaVisita == null) {
        return 0;
      } else {
        return 1;
      }
    }));
  }

  cacheCustomers() async {
    if (customers.isNotEmpty) {
      await storage.write(key: "route-customers", value: jsonEncode(customers));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  handleSelectCustomer(RouteCustomerModel customer) {
    showBottomSheet(
        context: Get.context!,
        builder: (BuildContext ctx) {
          return CustomerMenu();
        });
  }

  test() {
    globalController.logout();
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
