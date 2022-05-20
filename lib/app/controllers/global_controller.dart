import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
//models

import '../models/auth/user_model.dart';
import '../routes/app_pages.dart';

class GlobalController extends GetxController {
  Rxn<UserModel>? user = Rxn<UserModel>();

  final storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    String? token = await this.token;
    if (token == null) return;
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      if (payload['id'] != null && payload['exp'] != null) {
        DateTime exp =
            DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        if (exp.isAfter(DateTime.now())) {
          user?.value = UserModel.fromMap(payload);
          return;
        }
        return;
      }
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<String?> get token async {
    return await storage.read(key: 'access-token');
  }

  Future<bool> verify() async {
    String? token = await this.token;
    if (token == null) return false;

    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      if (payload['id'] != null && payload['exp'] != null) {
        DateTime exp =
            DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        if (exp.isAfter(DateTime.now())) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  saveSession(String token) async {
    await storage.write(key: 'access-token', value: token);
    await init();
    Get.offAllNamed(Routes.ROUTE_CUSTOMERS);
  }

  // logout() async {
  //   await storage.delete(key: 'access-token');
  //   user = Rxn<UserModel>();
  //   Get.offAllNamed(Routes.LOGIN);
  // }
}
