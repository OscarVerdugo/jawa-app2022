import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/product/product_model.dart';

import '../../../utils/ui/ui.dart';

class ProductToReceiveItem extends StatelessWidget {
  late UIText textStyles;
  final ProductModel product;
  final void Function() onTap;

  ProductToReceiveItem({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return UICardButtonWrapper(
        height: 65,
        child: _productItemInfo(),
        color: UIColors.white,
        onTap: onTap);
  }

  Row _productItemInfo() => Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.producto, style: textStyles.itemTitle),
            Text(product.presentacion, style: textStyles.inputText)
          ],
        ),
        Expanded(child: Container()),
        Text("Seleccionar", style: textStyles.badgeDescriptionSm),
      ]);
}
