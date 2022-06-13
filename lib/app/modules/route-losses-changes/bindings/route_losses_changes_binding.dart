import 'package:get/get.dart';

import '../controllers/route_losses_changes_controller.dart';

class RouteLossesChangesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouteLossesChangesController>(
      () => RouteLossesChangesController(),
    );
  }
}
