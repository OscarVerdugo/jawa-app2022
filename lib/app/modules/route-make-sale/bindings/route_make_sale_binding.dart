import 'package:get/get.dart';

import '../controllers/route_make_sale_controller.dart';

class RouteMakeSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouteMakeSaleController>(
      () => RouteMakeSaleController(),
    );
  }
}
