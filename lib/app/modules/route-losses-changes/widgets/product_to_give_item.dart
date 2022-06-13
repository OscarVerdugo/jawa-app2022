import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/product/product_model.dart';

import '../../../utils/ui/ui.dart';

class ProductToGiveItem extends StatelessWidget {
  late UIText textStyles;
  final ProductModel product;
  final void Function() onTap;

  ProductToGiveItem({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);

    return UICardButtonWrapper(
        onTap: onTap,
        color: UIColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(product.producto, style: textStyles.itemTitle),
                  Text("  ${product.disponible} Disponibles",
                      style: textStyles.badgeDescriptionSm)
                ]),
                Text(product.presentacion, style: textStyles.inputText)
              ],
            ),
            SizedBox(width: 16),
            if (product.cantidad == null)
              Text("Seleccionar", style: textStyles.badgeDescriptionSm),
            if (product.cantidad != null)
              Text.rich(TextSpan(children: [
                TextSpan(text: "Seleccionados ", style: textStyles.itemInfoSm),
                TextSpan(
                    text: "${product.cantidad}",
                    style: textStyles.h5.copyWith(color: UIColors.blue))
              ])),
          ],
        ));
  }
}
