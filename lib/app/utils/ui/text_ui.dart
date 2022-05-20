import 'package:flutter/material.dart';
import 'package:jawa_app/app/utils/ui/color_ui.dart';

class UIText {
  late BuildContext context;
  late TextTheme theme;
  UIText(BuildContext _context) {
    context = _context;
    theme = Theme.of(context).textTheme;
  }

  TextStyle get h6 {
    return theme.headline6!.copyWith(color: UIColors.darkColor);
  }

  TextStyle get h3 {
    return theme.headline3!
        .copyWith(color: UIColors.darkColor, fontWeight: FontWeight.w700);
  }

  TextStyle get titleSm {
    return theme.titleSmall!.copyWith(color: UIColors.darkColor, fontSize: 15);
  }

  TextStyle get message {
    return theme.subtitle1!.copyWith(
        color: UIColors.darkColor, fontSize: 15, fontWeight: FontWeight.w500);
  }

  TextStyle get button {
    return theme.button!.copyWith(
        fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1.5);
  }

  TextStyle get inputTextLabel {
    return theme.titleSmall!.copyWith(
        color: UIColors.darkColor.withOpacity(0.9),
        fontSize: 15,
        fontWeight: FontWeight.w600);
  }

  TextStyle get inputText {
    return theme.bodySmall!.copyWith(
        color: UIColors.darkColor.withOpacity(0.7),
        letterSpacing: 0.5,
        fontSize: 15,
        fontWeight: FontWeight.w600);
  }
}
