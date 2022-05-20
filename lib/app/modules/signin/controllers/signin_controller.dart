import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/services/auth_service.dart';
import 'package:jawa_app/app/utils/connection.dart';

class SigninController extends GetxController {
  final _authService = AuthService();

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final displayMessage = RxBool(false);
  final message = RxnString("Comprueba tus datos por favor");

  final loading = RxBool(false);
  final hasConnection = RxBool(false);

  late StreamSubscription _connectionStream;

  @override
  void onInit() async {
    onLogin();
    super.onInit();

    Connection connection = Connection.getInstance();
    _connectionStream =
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

  void onLogin() async {
    print("LOGIN");
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
