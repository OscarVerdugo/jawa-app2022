import 'package:flutter/material.dart';

import '../ui.dart';

class UICardButtonWrapper extends StatelessWidget {
  late UIText textStyles;

  final void Function() onTap;
  final double height;
  final Color color;
  final Widget child;
  UICardButtonWrapper(
      {Key? key,
      required this.onTap,
      required this.child,
      this.height = 50,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        color: color,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
