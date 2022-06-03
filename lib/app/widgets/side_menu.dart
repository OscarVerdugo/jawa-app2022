import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/utils/ui/color_ui.dart';

import '../utils/ui/ui.dart';

class SideMenu extends StatelessWidget {
  late UIText textStyles;
  final globalController = Get.find<GlobalController>();
  SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);

    return Drawer(
      backgroundColor: UIColors.lightColor,
      child: _body(),
    );
  }

  SafeArea _body() => SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_userInfo()]),
        ),
      ));

  Widget _userInfo() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: UIColors.darkColor02, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Vendedor",
          style:
              textStyles.inputTextLabel.copyWith(color: UIColors.darkColor75),
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: globalController.user.value!.name, style: textStyles.h5),
          TextSpan(
              text: " (${globalController.route.value!.sucursal.descripcion})",
              style: textStyles.inputText)
        ])),
        SizedBox(height: 4),
        Text(
          "En ruta ${globalController.route.value!.rutaDiariaDesc}",
          style:
              textStyles.inputTextLabel.copyWith(color: UIColors.darkColor75),
        ),
      ]),
    );
  }
}
