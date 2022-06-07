import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/routes/app_pages.dart';

import '../utils/ui/ui.dart';

class SideMenu extends StatelessWidget {
  late UIText textStyles;
  final globalController = Get.find<GlobalController>();
  late String currentRoute;
  SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    currentRoute = Get.currentRoute;
    return Drawer(
      backgroundColor: UIColors.lightColor,
      child: _body(),
    );
  }

  SafeArea _body() => SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _userInfo(),
            SizedBox(height: 4),
            _vehicleInfo(),
            SizedBox(height: 16),
            _options()
          ]),
        ),
      ));

  Widget _options() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Menú",
              style: textStyles.inputTextLabel
                  .copyWith(color: UIColors.darkColor75),
            ),
          ),
          SizedBox(height: 8),
          _menuOption(
              icon: Icons.people_rounded,
              color: UIColors.darkColor,
              route: Routes.ROUTE_CUSTOMERS,
              label: "Ruta"),
          _menuOption(
              icon: Icons.kitchen_rounded,
              color: UIColors.darkColor,
              route: Routes.ROUTE_INVENTORY,
              label: "Inventario"),
          _menuOption(
              icon: Icons.logout_rounded,
              color: UIColors.red,
              opacity: 0,
              label: "Cerrar sesión")
        ],
      );
  Widget _menuOption(
      {required IconData icon,
      required Color color,
      required String label,
      void Function()? onTap,
      double opacity = 0.02,
      String? route}) {
    color = route != null && route == currentRoute ? UIColors.blue : color;
    opacity = route != null && route == currentRoute ? 0.1 : opacity;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            onTap: onTap ??
                () {
                  if (currentRoute == route) {
                    Get.back();
                  } else {
                    Get.offNamed(route!);
                  }
                },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 24),
                  SizedBox(width: 16),
                  Text(label,
                      style: textStyles.itemTitle.copyWith(color: color))
                ],
              ),
            )),
      ),
    );
  }

  Widget _userInfo() {
    return UICardWrapper(
      color: Colors.transparent,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Vendedor",
          style:
              textStyles.inputTextLabel.copyWith(color: UIColors.darkColor75),
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: globalController.user.value!.name, style: textStyles.h5),
          TextSpan(
              text: " (${globalController.route.value!.sucursal.descripcion})",
              style: textStyles.inputText)
        ])),
        SizedBox(height: 4),
        Text(
          "En ruta ${globalController.route.value!.rutaDiariaDesc}",
          style:
              textStyles.inputTextLabel.copyWith(color: UIColors.darkColor75),
        ),
      ]),
    );
  }

  Widget _vehicleInfo() {
    if (globalController.route.value != null &&
        globalController.route.value!.vehiculo != null) {
      return UICardWrapper(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vehículo",
                style: textStyles.inputTextLabel
                    .copyWith(color: UIColors.darkColor75),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: globalController.route.value!.vehiculo!.placas,
                    style: textStyles.itemTitle),
                TextSpan(
                    text:
                        " ${globalController.route.value!.vehiculo!.description}",
                    style: textStyles.inputText)
              ])),
            ],
          ));
    } else {
      return Container();
    }
  }
}
