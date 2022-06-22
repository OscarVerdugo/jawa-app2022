import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/route/customer_view_model.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class CustomerItem extends StatelessWidget {
  late UIText textStyles;
  final CustomerViewModel customer;
  final void Function() onTap;
  CustomerItem({Key? key, required this.customer, required this.onTap})
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
                Text(customer.nombre, style: textStyles.itemTitle),
              ],
            ),
            SizedBox(width: 16),
            Text("Agregar", style: textStyles.badgeDescriptionSm)
          ],
        ));
  }
}
