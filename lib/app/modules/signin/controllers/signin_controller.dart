import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/routes/app_pages.dart';
import 'package:jawa_app/app/services/auth_service.dart';
import 'package:jawa_app/app/utils/connection.dart';

import '../../../controllers/global_controller.dart';

class SigninController extends GetxController {
  final _authService = AuthService();

  final _globalCtl = Get.find<GlobalController>();

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final displayMessage = RxBool(false);
  final message = RxnString(null);

  final loading = RxBool(false);
  final hasConnection = RxBool(false);

  @override
  void onInit() async {
    super.onInit();

    Connection connection = Connection.getInstance();
    connection.onConnectionChange.listen(onChangeConnection);
    hasConnection.value = await connection.checkConnection();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void handleSignin() async {
    if (formKey.currentState!.validate() && hasConnection.value) {
      loading.value = true;
      final res = await _authService.signin(
          username: usernameCtrl.text, password: passwordCtrl.text);
      loading.value = false;
      if (res.success) {
        onLogin(res.data);
      } else {
        displayMessage.value = true;
        message.value = res.message;
        hideMessage();
      }
    }
    update();
  }

  void hideMessage() {
    Future.delayed(const Duration(seconds: 5), (() {
      displayMessage.value = false;
      message.value = null;
      update();
    }));
  }

  void onLogin(String? token) async {
    if (token != null) {
      await _globalCtl.saveSession(token);
      Get.offNamed(Routes.LANDING);
    } else {
      displayMessage.value = true;
      message.value = "Ocurrió algo al iniciar sesión, intenta de nuevo.";
      hideMessage();
    }
  }

  void onChangeConnection(bool hasConnection) {
    this.hasConnection.value = hasConnection;
    if (!hasConnection) {
      displayMessage.value = true;
      message.value = "Necesitas conexión a internet para iniciar";
    } else {
      displayMessage.value = false;
      message.value = null;
    }
  }
}
