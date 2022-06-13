import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/product/inventory_product_model.dart';

import '../../../utils/ui/ui.dart';

class ProductItem extends StatelessWidget {
  final InventoryProductModel product;
  late UIText textStyles;

  ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return UICardWrapper(
        height: 65, child: _productItemInfo(), color: UIColors.white);
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
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(text: "Recargado ", style: textStyles.itemInfoSm),
            TextSpan(
                text: "${product.recargado}", style: textStyles.inputTextLabel)
          ])),
          SizedBox(height: 4),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: "Últ. recarga ", style: textStyles.itemInfoSm),
            TextSpan(
                text: "${product.ultimaRecarga}",
                style: textStyles.inputTextLabel)
          ]))
        ]),
        SizedBox(width: 16),
        Text("Existencia  ", style: textStyles.itemInfoSm),
        Text("${product.disponible}",
            style: textStyles.h5.copyWith(color: UIColors.blue)),
      ]);
}
