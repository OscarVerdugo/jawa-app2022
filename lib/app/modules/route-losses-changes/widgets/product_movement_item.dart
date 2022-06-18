import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/product/product_movement_model.dart';

import '../../../utils/ui/ui.dart';

class ProductMovementItem extends StatelessWidget {
  final ProductMovementModel movement;
  final void Function() onTap;
  late UIText textStyles;

  final Map<String, dynamic> toGive;
  final Map<String, dynamic> toReceive;

  ProductMovementItem(
      {Key? key,
      required this.movement,
      required this.onTap,
      required this.toGive,
      required this.toReceive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);

    return UICardButtonWrapper(
        onTap: onTap,
        color: UIColors.white,
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(toGive['producto'], style: textStyles.itemTitle),
                  Text(toGive['presentacion'], style: textStyles.inputText)
                ],
              ),
            ),
            Text("${movement.cantidad}",
                style: textStyles.h5.copyWith(color: UIColors.blue)),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(toReceive['producto'], style: textStyles.itemTitle),
                  Text(toReceive['presentacion'], style: textStyles.inputText)
                ],
              ),
            ),
          ],
        ));
  }
}
