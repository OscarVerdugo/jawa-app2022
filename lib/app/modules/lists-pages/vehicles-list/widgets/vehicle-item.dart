import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/route/vehicle_model.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class VehicleItem extends StatelessWidget {
  final VehicleModel vehicle;
  final UIText textStyles;
  final void Function()? onTap;
  const VehicleItem(
      {Key? key, required this.textStyles, required this.vehicle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 60,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${vehicle.placas}",
                        style: textStyles.itemTitle,
                      ),
                      Text("${vehicle.marca} ${vehicle.modelo}",
                          style: textStyles.itemInfo),
                    ],
                  ),
                  _colorBadge()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _colorBadge() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UIColors.fromHex(vehicle.color)),
          width: 50,
          height: 25,
        ),
      ),
    );
  }
}
