import 'package:flutter/material.dart';

import '../ui.dart';

class UICardWrapper extends StatelessWidget {
  final Color color;
  final double height;
  final Widget child;
  const UICardWrapper(
      {Key? key, required this.color, this.height = 50, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: child)),
    );
  }
}
