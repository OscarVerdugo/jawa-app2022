import 'package:flutter/material.dart';

class UIColors {
  static final lightColor = Color.fromRGBO(242, 242, 242, 1);
  static final darkColor = Color.fromRGBO(48, 57, 82, 1);
  static final darkColor90 = Color.fromRGBO(48, 57, 82, 0.9);
  static final darkColor80 = Color.fromRGBO(48, 57, 82, 0.8);
  static final darkColor75 = Color.fromRGBO(48, 57, 82, 0.75);
  static final darkColor60 = Color.fromRGBO(48, 57, 82, 0.6);
  static final darkColor45 = Color.fromRGBO(48, 57, 82, 0.45);
  static final darkColor25 = Color.fromRGBO(48, 57, 82, 0.25);
  static final darkColor15 = Color.fromRGBO(48, 57, 82, 0.15);
  static final darkColor10 = Color.fromRGBO(48, 57, 82, 0.10);
  static final darkColor05 = Color.fromRGBO(48, 57, 82, 0.05);

  static final white = Color.fromRGBO(255, 255, 255, 1);
  static final red = Color.fromRGBO(255, 118, 117, 1.0);
  static final blue = Color.fromRGBO(41, 128, 185, 1.0);
  static final darkBlue = Color.fromRGBO(61, 193, 211, 1.0);
  static final orange = Color.fromRGBO(243, 166, 131, 1.0);
  static final yellow = Color.fromRGBO(247, 215, 148, 1.0);

  static Color fromHex(hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
