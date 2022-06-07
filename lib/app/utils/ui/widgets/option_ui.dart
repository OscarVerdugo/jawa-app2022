import 'package:flutter/material.dart';

import '../ui.dart';

class UIOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  late UIText textStyles;

  UIOption(
      {Key? key, required this.color, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 16),
        Text(label, style: textStyles.itemTitle.copyWith(color: color))
      ],
    );
  }
}
