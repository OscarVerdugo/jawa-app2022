import 'package:flutter/material.dart';
import 'package:jawa_app/app/models/product/product_refill_model.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

import '../../../utils/constants.dart';

class RefillItem extends StatelessWidget {
  final ProductRefillModel refill;
  late UIText textStyles;
  final void Function() onTap;
  final void Function(bool?) onAccept;

  RefillItem(
      {Key? key,
      required this.refill,
      required this.onAccept,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    final canAnswer = refill.estatus == STATUS.PENDING &&
        refill.origen == REFILL_ORIGIN.BRANCH;
    return Padding(
      padding: EdgeInsets.only(bottom: canAnswer ? 4 : 0),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: canAnswer ? 29 : 0),
            child: UICardButtonWrapper(
                onTap: () {},
                color: UIColors.white,
                height: 65,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(refill.producto, style: textStyles.itemTitle),
                        Text(refill.presentacion, style: textStyles.inputText)
                      ],
                    ),
                    Expanded(child: Container()),
                    Row(children: [
                      Text("${refill.cantidad}",
                          style: textStyles.h5.copyWith(
                              color: refill.cantidad > 0
                                  ? UIColors.blue
                                  : UIColors.red)),
                      SizedBox(width: 4),
                      Text("Pzs", style: textStyles.inputText)
                    ])
                  ],
                )),
          ),
          _controls(canAnswer: canAnswer),
          _status()
        ],
      ),
    );
  }

  Widget _status() {
    if (refill.estatus == "PEN" && refill.origen == "SUC") return Container();
    return Positioned(
        top: 46,
        right: 0,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  color: UIColors.darkColor10),
              child: Text(
                  refill.origen == "SUC" ? "Desde sucursal" : "Solicitado",
                  style: textStyles.badgeDescriptionXs
                      .copyWith(color: UIColors.darkColor75)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10)),
                  color: _getStatusColor),
              child: Text(_getStatusLabel,
                  style: textStyles.badgeDescriptionXs
                      .copyWith(color: UIColors.white)),
            ),
          ],
        ));
  }

  Widget _controls({required bool canAnswer}) {
    if (canAnswer) {
      return Positioned(
          bottom: 0,
          right: 15,
          child: Container(
            height: 33,
            padding: EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 4),
            decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child:
                Row(children: [..._controlsAnswered(), ..._controlsPending()]),
          ));
    } else {
      return Container();
    }
  }

  List<Widget> _controlsPending() {
    if (refill.aceptado == null) {
      return [
        UISamllButton.text(
            text: "Rechazar",
            color: UIColors.red,
            onTap: () {
              onAccept(false);
            }),
        SizedBox(width: 8),
        UISamllButton.flat(
            text: "Aceptar",
            color: UIColors.green,
            onTap: () {
              onAccept(true);
            })
      ];
    } else {
      return [Container()];
    }
  }

  List<Widget> _controlsAnswered() {
    if (refill.aceptado == true) {
      return [
        UISamllButton.flat(
            text: "Aceptado",
            color: UIColors.green,
            onTap: () {
              onAccept(null);
            })
      ];
    } else if (refill.aceptado == false) {
      return [
        UISamllButton.flat(
            text: "Rechazado",
            color: UIColors.red,
            onTap: () {
              onAccept(null);
            })
      ];
    } else {
      return [Container()];
    }
  }

  String get _getStatusLabel {
    if (refill.estatus == STATUS.ACTIVE) {
      return "A"; //AUTORIZADO
    } else if (refill.estatus == STATUS.REJECTED) {
      return "R"; //RECHAZADO
    }
    if (refill.origen == REFILL_ORIGIN.ROUTE &&
        refill.estatus == STATUS.PENDING) {
      return "P"; //PENDIENTE DE ACEPTACION DE PRODUCCION
    } else {
      return ""; //PENDIENTE DE ACEPTACION DEL VENDEDOR
    }
  }

  Color get _getStatusColor {
    if (refill.estatus == STATUS.ACTIVE) {
      return UIColors.green; //AUTORIZADO
    } else if (refill.estatus == STATUS.REJECTED) {
      return UIColors.red; //RECHAZADO
    }
    if (refill.origen == REFILL_ORIGIN.ROUTE &&
        refill.estatus == STATUS.PENDING) {
      return UIColors.orange; //PENDIENTE DE ACEPTACION DE PRODUCCION
    } else {
      return UIColors.white; //PENDIENTE DE ACEPTACION DEL VENDEDOR
    }
  }
}
