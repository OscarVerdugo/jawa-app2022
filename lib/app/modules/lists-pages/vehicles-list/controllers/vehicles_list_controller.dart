import 'package:get/get.dart';
import 'package:jawa_app/app/models/route/vehicle_model.dart';
import 'package:jawa_app/app/modules/initialize-route/controllers/initialize_route_controller.dart';
import 'package:jawa_app/app/services/general_service.dart';

import '../../../../utils/utils.dart';

class VehiclesListController extends GetxController {
  final generalService = GeneralService();
  final initializeRouteController = Get.find<InitializeRouteController>();

  final loading = RxBool(false);
  final vehicles = RxList<VehicleModel>();

  final hasConnection = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    Connection connection = Connection.getInstance();
    connection.onConnectionChange.listen(onChangeConnection);
    hasConnection.value = await connection.checkConnection();
    loadVehicles();
  }

  void loadVehicles() async {
    loading.value = true;
    if (hasConnection.value) {
      final res = await generalService.getVehicles();
      loading.value = false;
      if (res.success && res.data != null) {
        vehicles.value = res.data ?? [];
        print(vehicles.length);
      } else {
        print(res.message);
        print("RESULT FAILURE");
      }
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  handleSelectVehicle(VehicleModel model) {
    initializeRouteController.onSelectVehicle(model);
    Get.back();
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
