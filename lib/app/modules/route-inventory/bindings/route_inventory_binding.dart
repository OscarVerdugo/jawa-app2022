import 'package:get/get.dart';

import '../controllers/route_inventory_controller.dart';

class RouteInventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteInventoryController());
  }
}
