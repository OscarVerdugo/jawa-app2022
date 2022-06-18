import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:jawa_app/app/models/product/product_movement_model.dart';
import 'package:jawa_app/app/models/route/route_customer_model.dart';
import 'package:jawa_app/app/modules/route-customers/controllers/route_customers_controller.dart';
import 'package:jawa_app/app/modules/route-losses-changes/controllers/route_losses_changes_controller.dart';
import 'package:jawa_app/app/utils/ui/widgets/menu_wrapper_ui.dart';
import 'package:jawa_app/app/utils/ui/widgets/option_ui.dart';

import '../../../utils/ui/ui.dart';

class MovementMenu extends StatelessWidget {
  final ProductMovementModel movement;
  final int index;
  final controller = Get.find<RouteLossesChangesController>();
  late UIText textStyles;
  MovementMenu({Key? key, required this.movement, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return UIMenuWrapper(children: [_content()]);
  }

  Widget _content() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Opciones", style: textStyles.h5),
        SizedBox(height: 8),
        UICardButtonWrapper(
            onTap: () {
              controller.handleRemoveMovement(index);
            },
            color: UIColors.darkColor02,
            child: UIOption(
                color: UIColors.red,
                icon: Icons.delete_rounded,
                label: "Eliminar"))
      ]),
    );
  }
}
