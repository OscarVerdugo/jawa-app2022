import 'package:get/get.dart';

import '../controllers/route_customers_controller.dart';

class RouteCustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouteCustomersController>(
      () => RouteCustomersController(),
    );
  }
}
