import 'package:get/get.dart';
import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/routes/app_pages.dart';

class LandingController extends GetxController {
  final _globalCtrl = Get.find<GlobalController>();

  @override
  void onInit() {
    super.onInit();
    verifySession();
  }

  void verifySession() async {
    if (await _globalCtrl.verify()) {
      await _globalCtrl.initRoute();
      if (_globalCtrl.route.value != null &&
          _globalCtrl.route.value!.horaInicio != null) {
        Get.offNamed(Routes.ROUTE_CUSTOMERS);
      } else {
        Get.offNamed(Routes.INITIALIZE_ROUTE);
      }
    } else {
      Get.offNamed(Routes.SIGNIN);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
