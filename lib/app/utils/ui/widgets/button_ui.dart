import 'package:flutter/material.dart';

import '../ui.dart';

class UIButton extends StatelessWidget {
  final bool loading;
  final Color color;
  final Color textColor;
  final String text;
  final bool fitContent;
  late UIText textStyles;
  final void Function()? onTap;
  UIButton(
      {Key? key,
      required this.loading,
      required this.color,
      required this.fitContent,
      required this.textColor,
      this.onTap,
      required this.text})
      : super(key: key);

  factory UIButton.text(
      {required Color color,
      required String text,
      bool loading = false,
      bool fitContent = false,
      Function()? onTap}) {
    return UIButton(
        loading: loading,
        textColor: color,
        fitContent: fitContent,
        text: text,
        color: Colors.transparent,
        onTap: onTap);
  }

  factory UIButton.flat(
      {required Color color,
      required String text,
      bool loading = false,
      bool fitContent = false,
      Function()? onTap}) {
    return UIButton(
        loading: loading,
        fitContent: fitContent,
        color: color,
        text: text,
        textColor: UIColors.white,
        onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: loading || fitContent ? 175 : constraints.maxWidth,
        height: 50,
        child: Material(
          color: loading && color != Colors.transparent
              ? color.withOpacity(0.7)
              : color,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: splashColor,
            highlightColor: Colors.transparent,
            onTap: loading ? null : onTap,
            child: Center(child: content),
          ),
        ),
      );
    });
  }

  Color? get splashColor {
    if (onTap != null) {
      if (color == Colors.transparent) {
        return textColor.withOpacity(0.2);
      } else {
        return Colors.white24;
      }
    } else {
      return null;
    }
  }

  Widget get content {
    if (loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: CircularProgressIndicator(
              color: textColor,
              strokeWidth: 2,
            ),
            height: 15.0,
            width: 15.0,
          ),
          SizedBox(width: 16),
          Text("Cargando...",
              style: textStyles.button.copyWith(color: textColor))
        ],
      );
    } else {
      return Text(text, style: textStyles.button.copyWith(color: textColor));
    }
  }
}
