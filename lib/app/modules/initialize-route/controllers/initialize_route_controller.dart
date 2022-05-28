import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/models/auth/user_model.dart';
import 'package:jawa_app/app/models/route/vehicle_model.dart';

import '../../../routes/app_pages.dart';

class InitializeRouteController extends GetxController {
  final globalCtrl = Get.find<GlobalController>();
  final user = Rxn<UserModel>(null);
  final vehicle = Rxn<VehicleModel>(null);
  final loading = RxBool(false);

  final initialMileageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool alreadyStarted = RxBool(false);
  final vehicleError = RxBool(false);

  @override
  void onInit() {
    user.value = globalCtrl.user.value;
    loadRoute();
    super.onInit();
  }

  void loadRoute() async {
    await globalCtrl.getRoute();
    if (globalCtrl.route.value != null) {
      vehicle.value = globalCtrl.route.value!.vehiculo;
      final initialMileage = globalCtrl.route.value!.kilometrajeInicial != 0
          ? globalCtrl.route.value!.kilometrajeInicial
          : "";
      initialMileageController.text = initialMileage.toString();
      if (vehicle.value != null) {
        alreadyStarted.value = true;
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  handleLogout() {
    globalCtrl.logout();
  }

  handleRefetchRoute() async {
    loadRoute();
  }

  onSelectVehicle(VehicleModel selected) {
    vehicle.value = selected;
  }

  handleStartRoute() {
    if (!alreadyStarted.value) {
      if (formKey.currentState!.validate() && vehicle.value != null) {
        onStartRoute();
      } else {
        vehicleError.value = true;
      }
    } else {
      Get.offNamed(Routes.ROUTE_CUSTOMERS);
    }
  }

  onStartRoute() async {
    final initialMileage = int.tryParse(initialMileageController.text)!;
    loading.value = true;
    final res = await globalCtrl.chooseVehicle(vehicle.value!, initialMileage);
    loading.value = false;
    if (res.success) {
      Get.offAllNamed(Routes.ROUTE_CUSTOMERS);
    }
  }

  handleGoToSelectVehicle() {
    Get.toNamed(Routes.VEHICLES_LIST);
  }

  @override
  void onClose() {}
}
