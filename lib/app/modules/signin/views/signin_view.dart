import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

import '../../../utils/utils.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  late UIText textStyles;
  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Bienvenido!", style: textStyles.h3),
                Text(" Inicia sesión para continuar",
                    style: textStyles.titleSm),
                SizedBox(height: 16),
                _form()
              ],
            ),
          ),
        ),
      );

  Widget _message() {
    return Obx(() {
      return AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: controller.displayMessage.value == false ? 0.0 : 1.0,
        child: Material(
          color: UIColors.red,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Container(
            height: 50,
            child: Center(
                child: Text("${controller.message}",
                    style: textStyles.message.copyWith(color: UIColors.white))),
          ),
        ),
      );
    });
  }

  Widget _form() {
    return GetBuilder<SigninController>(builder: (ctx) {
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            UITextField(
              label: "Usuario",
              controller: controller.usernameCtrl,
              validator: Validators.username,
            ),
            SizedBox(height: 16),
            UITextField(
                controller: controller.passwordCtrl,
                label: "Contraseña",
                password: true,
                validator: Validators.password),
            SizedBox(height: 8),
            _message(),
            SizedBox(height: 16),
            Obx(() => UIButton.flat(
                text: "Iniciar",
                color: UIColors.blue,
                loading: controller.loading.value,
                onTap: controller.handleSignin))
          ],
        ),
      );
    });
  }
}
