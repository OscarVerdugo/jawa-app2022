import 'package:flutter/material.dart';

import '../ui.dart';

class UILoading extends StatelessWidget {
  final String? message;
  late UIText textStyles;

  UILoading({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
                color: UIColors.blue, strokeWidth: 5)),
        SizedBox(height: 16),
        Text(message ?? "Cargando...",
            style: textStyles.titleSm
                .copyWith(color: UIColors.darkColor.withOpacity(0.8)))
      ]),
    );
  }
}
