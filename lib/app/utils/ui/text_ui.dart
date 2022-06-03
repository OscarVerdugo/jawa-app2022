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

  TextStyle get h4 {
    return theme.headline4!
        .copyWith(color: UIColors.darkColor, fontWeight: FontWeight.w700);
  }

  TextStyle get h5 {
    return theme.headline5!
        .copyWith(color: UIColors.darkColor, fontWeight: FontWeight.w700);
  }

  TextStyle get titleSm {
    return theme.titleSmall!.copyWith(color: UIColors.darkColor, fontSize: 15);
  }

  TextStyle get titleMd {
    return theme.titleMedium!.copyWith(color: UIColors.darkColor);
  }

  TextStyle get titleLg {
    return theme.titleLarge!.copyWith(color: UIColors.darkColor);
  }

  TextStyle get message {
    return theme.subtitle1!.copyWith(
        color: UIColors.darkColor, fontSize: 15, fontWeight: FontWeight.w500);
  }

  TextStyle get itemInfo {
    return theme.bodyMedium!
        .copyWith(color: UIColors.darkColor75, fontWeight: FontWeight.w500);
  }

  TextStyle get itemInfoSm {
    return theme.bodyMedium!.copyWith(
        color: UIColors.darkColor75, fontWeight: FontWeight.w600, fontSize: 12);
  }

  TextStyle get itemTitle {
    return theme.titleMedium!
        .copyWith(color: UIColors.darkColor, fontWeight: FontWeight.w600);
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

  TextStyle get inputTextLabelSm {
    return theme.titleSmall!.copyWith(
        color: UIColors.darkColor.withOpacity(0.9),
        fontSize: 13,
        fontWeight: FontWeight.w600);
  }

  TextStyle get inputText {
    return theme.bodySmall!.copyWith(
        color: UIColors.darkColor.withOpacity(0.7),
        letterSpacing: 0.5,
        fontSize: 15,
        fontWeight: FontWeight.w600);
  }

  TextStyle get inputTextSm {
    return theme.bodySmall!.copyWith(
        color: UIColors.darkColor.withOpacity(0.6),
        letterSpacing: 0.5,
        fontSize: 12,
        fontWeight: FontWeight.w600);
  }

  TextStyle get badgeDescriptionSm {
    return theme.bodySmall!.copyWith(
        color: UIColors.darkColor.withOpacity(0.5),
        letterSpacing: 0.5,
        fontSize: 11,
        fontWeight: FontWeight.w600);
  }
}
