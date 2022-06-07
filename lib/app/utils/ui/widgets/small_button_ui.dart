import 'package:flutter/material.dart';

import '../ui.dart';

class UISamllButton extends StatelessWidget {
  late UIText textStyles;
  final String text;
  final Color color;
  final Color textColor;
  final void Function() onTap;
  UISamllButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.textColor,
      required this.onTap})
      : super(key: key);
  factory UISamllButton.text(
      {required String text,
      required Color color,
      required void Function() onTap}) {
    return UISamllButton(
        text: text, color: Colors.transparent, textColor: color, onTap: onTap);
  }
  factory UISamllButton.flat(
      {required String text,
      required Color color,
      required void Function() onTap}) {
    return UISamllButton(
      text: text,
      color: color,
      textColor: Colors.white,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            text,
            style: textStyles.buttonSm.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
