import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class UIQuantityBottomSheetService {
  static Future request(BuildContext context, {int? initial}) {
    final TextEditingController controller = TextEditingController();
    final Completer completer = Completer();
    controller.text = "${initial ?? ''}";
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.black12,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return UIQuantityBottomSheet(controller: controller);
        }).whenComplete(() {
      var value = int.tryParse(controller.text);
      if (value == 0) value = null;
      completer.complete(value);
    });
    return completer.future;
  }
}
