import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/product/product_model.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class RequestableProductItem extends StatelessWidget {
  final ProductModel product;
  final void Function() onTap;
  final bool isReturn;
  late UIText textStyles;

  RequestableProductItem(
      {Key? key,
      required this.product,
      required this.onTap,
      this.isReturn = false})
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
              Text(isReturn ? "Retornar" : "Solicitar",
                  style: textStyles.badgeDescriptionSm),
            if (product.cantidad != null)
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: isReturn ? "Retornados " : "Solicitados ",
                    style: textStyles.itemInfoSm),
                TextSpan(
                    text: "${product.cantidad}",
                    style: textStyles.h5.copyWith(
                        color: isReturn ? UIColors.red : UIColors.blue))
              ])),
          ],
        ));
  }
}
