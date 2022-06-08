import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';
import 'package:jawa_app/app/utils/ui/widgets/alert_ui.dart';

class UIAlertService {
  static showConfirm(BuildContext context,
      {required String title,
      required String message,
      required void Function() onAccept,
      void Function()? onBack,
      String? acceptText,
      String? backText}) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return UIAlert(
            title: title,
            message: message,
            accept: UISamllButton.flat(
                color: UIColors.green,
                text: acceptText ?? "Aceptar",
                onTap: () {
                  Get.back();
                  onAccept();
                }),
            back: UISamllButton.text(
                color: UIColors.darkColor75,
                text: backText ?? "Regresar",
                onTap: () {
                  Get.back();
                  if (onBack != null) onBack();
                }),
          );
        });
  }
}
