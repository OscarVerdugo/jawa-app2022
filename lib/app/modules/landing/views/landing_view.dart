import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/utils/ui/color_ui.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  late UIText textStyles;

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);

    return Scaffold(
      body: _body(),
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _progress(),
            SizedBox(height: 16),
            Text("Verificando sesión",
                style: textStyles.titleSm
                    .copyWith(color: UIColors.darkColor.withOpacity(0.8)))
          ],
        ),
      ),
    );
  }

  SizedBox _progress() {
    return SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(color: UIColors.blue, strokeWidth: 5));
  }
}
