import 'package:get/get.dart';

import '../controllers/route_add_customer_controller.dart';

class RouteAddCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RouteAddCustomerController>(RouteAddCustomerController());
  }
}
