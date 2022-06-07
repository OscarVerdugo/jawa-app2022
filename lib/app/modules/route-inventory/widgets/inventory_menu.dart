import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-inventory/controllers/route_inventory_controller.dart';
import 'package:jawa_app/app/utils/ui/widgets/menu_wrapper_ui.dart';
import 'package:jawa_app/app/utils/ui/widgets/option_ui.dart';

import '../../../utils/ui/ui.dart';

class InventoryMenu extends StatelessWidget {
  late UIText textStyles;
  final controller = Get.find<RouteInventoryController>();
  InventoryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return UIMenuWrapper(
      children: [_menuTitle(), SizedBox(height: 8), ..._options()],
    );
  }

  Widget _menuTitle() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: "Opciones ", style: textStyles.h5),
      TextSpan(text: "- Inventario", style: textStyles.inputTextLabel),
    ]));
  }

  List<Widget> _options() {
    return [
      UICardButtonWrapper(
        onTap: controller.handleGoToRefills,
        color: UIColors.darkColor02,
        child: UIOption(
            color: UIColors.darkColor,
            icon: Icons.list_alt_rounded,
            label: "Recargas"),
      ),
      UICardButtonWrapper(
        onTap: () {},
        color: UIColors.darkColor02,
        child: UIOption(
            color: UIColors.darkColor,
            icon: Icons.playlist_add_rounded,
            label: "Solicitar recarga"),
      ),
      UICardButtonWrapper(
        onTap: () {},
        color: UIColors.darkColor02,
        child: UIOption(
            color: UIColors.darkColor,
            icon: Icons.playlist_remove_rounded,
            label: "Regresar producto"),
      )
    ];
  }
}
