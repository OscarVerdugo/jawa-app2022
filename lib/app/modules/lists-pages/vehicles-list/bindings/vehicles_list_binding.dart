import 'package:get/get.dart';

import '../controllers/vehicles_list_controller.dart';

class VehiclesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VehiclesListController());
  }
}
