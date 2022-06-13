import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:jawa_app/app/models/route/route_customer_model.dart';
import 'package:jawa_app/app/modules/route-customers/controllers/route_customers_controller.dart';
import 'package:jawa_app/app/utils/ui/widgets/menu_wrapper_ui.dart';
import 'package:jawa_app/app/utils/ui/widgets/option_ui.dart';

import '../../../utils/ui/ui.dart';

class CustomerMenu extends StatelessWidget {
  final RouteCustomerModel customer;
  final controller = Get.find<RouteCustomersController>();
  late UIText textStyles;
  CustomerMenu({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return UIMenuWrapper(children: [_customerInfo()]);
  }

  Widget _customerInfo() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(customer.cliente, style: textStyles.h5),
        SizedBox(height: 4),
        _customerInfoComment(),
        _visitDetails(),
        SizedBox(height: 4),
        if (customer.telefonoEncargado != null) _callManagerOption(),
        if (customer.telefono != null) _callCustomerOption(),
        _option(
            color: UIColors.blue,
            label: "Vender productos",
            onTap: () {
              controller.handleMakeSale();
            },
            icon: Icons.sell_rounded),
        if (customer.horaVisita == null)
          _option(
              color: UIColors.blue,
              label: "Visitar cliente",
              onTap: () {},
              icon: Icons.person_pin_circle_rounded),
        if (customer.notasAsignadas.isNotEmpty) _optionAssignedNotes(),
        _option(
            color: UIColors.orange,
            label: "Cambiar productos",
            onTap: () {
              controller.handleMakeChange();
            },
            icon: Icons.swap_horiz_rounded),
        _option(
            label: "Cambiar mermas",
            color: UIColors.red,
            onTap: () {
              controller.handleMakeLoss();
            },
            icon: Icons.flip_camera_android_rounded),
      ]),
    );
  }

  Widget _customerInfoComment() {
    if (customer.comentarios != null) {
      return UICardWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Comentario", style: textStyles.inputTextLabel),
              SizedBox(height: 2),
              Text(customer.comentarios!, style: textStyles.inputTextSm)
            ],
          ),
          color: UIColors.darkColor02);
    } else {
      return Container();
    }
  }

  Widget _visitDetails() {
    if (customer.horaVisita != null) {
      return UICardWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Visitado a las ${customer.horaVisitaTexto}",
                style: textStyles.itemTitle,
              ),
              SizedBox(height: 2),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Atendió: ", style: textStyles.inputTextLabelSm),
                TextSpan(text: customer.atendio, style: textStyles.inputTextSm)
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Motivo de visita: ",
                    style: textStyles.inputTextLabelSm),
                TextSpan(
                    text: customer.motivoVisita, style: textStyles.inputTextSm)
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Observación: ", style: textStyles.inputTextLabelSm),
                TextSpan(
                    text: customer.observacion, style: textStyles.inputTextSm)
              ]))
            ],
          ),
          color: UIColors.darkColor02);
    } else {
      return Container();
    }
  }

  Widget _callManagerOption() {
    return UICardButtonWrapper(
        color: UIColors.darkColor02,
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.phone_rounded, color: UIColors.darkColor, size: 24),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Llamar a ${customer.nombreEncargado != null ? customer.nombreEncargado! + " (encargado)" : "encargado"}",
                    style: textStyles.itemTitle),
                Text(
                  customer.telefonoEncargado ?? "Sin telefono",
                  style: textStyles.itemInfoSm,
                )
              ],
            )
          ],
        ));
  }

  Widget _callCustomerOption() {
    return UICardButtonWrapper(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.phone_rounded, color: UIColors.darkColor, size: 24),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Llamar a ${customer.cliente}",
                    style: textStyles.itemTitle),
                Text(
                  customer.telefono ?? "Sin telefono",
                  style: textStyles.itemInfoSm,
                )
              ],
            )
          ],
        ),
        color: UIColors.darkColor02);
  }

  Widget _option(
      {required IconData icon,
      required String label,
      required void Function() onTap,
      Color? color}) {
    color ??= UIColors.darkColor;

    return UICardButtonWrapper(
        onTap: onTap,
        child: UIOption(color: color, icon: icon, label: label),
        color: UIColors.darkColor02);
  }

  Widget _optionAssignedNotes() {
    return UICardButtonWrapper(
        color: UIColors.darkColor02,
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.assignment_rounded, color: UIColors.orange, size: 24),
            SizedBox(width: 16),
            Text("Notas pendientes",
                style: textStyles.itemTitle.copyWith(color: UIColors.orange)),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                  color: UIColors.orange,
                  borderRadius: BorderRadius.circular(5)),
              child: Text("${customer.notasAsignadas.length}",
                  style: textStyles.itemInfoSm.copyWith(
                      fontWeight: FontWeight.w800, color: UIColors.white)),
            )
          ],
        ));
  }
}
