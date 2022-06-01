import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/route/route_customer_model.dart';
import 'package:jawa_app/app/utils/ui/color_ui.dart';

import '../../../utils/ui/ui.dart';

class RouteCustomerItem extends StatelessWidget {
  final RouteCustomerModel customer;
  final UIText textStyles;
  final void Function() onTap;
  const RouteCustomerItem(
      {Key? key,
      required this.customer,
      required this.onTap,
      required this.textStyles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Material(
          color:
              customer.horaVisita != null ? Colors.transparent : UIColors.white,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 75,
              child: _info(),
            ),
          ),
        ));
  }

  Widget _info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(customer.cliente, style: textStyles.itemTitle),
            if (customer.notasAsignadas.isNotEmpty) _assignedNotesBadge()
          ],
        ),
        if (customer.horaVisita != null) _visited()
      ],
    );
  }

  Widget _visited() => Text("VISITADO",
      style: textStyles.message.copyWith(color: UIColors.darkColor75));

  Widget _assignedNotesBadge() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Notas", style: textStyles.itemInfoSm),
          SizedBox(width: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
                color: UIColors.yellow, borderRadius: BorderRadius.circular(5)),
            child: Text("${customer.notasAsignadas.length}",
                style: textStyles.itemInfoSm
                    .copyWith(fontWeight: FontWeight.w800)),
          )
        ],
      ),
    );
  }
}
