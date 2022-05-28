import 'package:get/get.dart';

import '../controllers/initialize_route_controller.dart';

class InitializeRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitializeRouteController>(
      () => InitializeRouteController(),
    );
  }
}
