import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-inventory/widgets/refill_item.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_inventory_controller.dart';

class RouteRefillsView extends GetView<RouteInventoryController> {
  late UIText textStyles;
  RouteRefillsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      appBar: AppBar(title: Text('Recargas'), centerTitle: true),
      bottomNavigationBar: _bottom(),
      body: _body(),
    );
  }

  SafeArea _body() => SafeArea(child: GetBuilder<RouteInventoryController>(
          builder: (RouteInventoryController builder) {
        if (controller.refillsLoading.value) {
          return UILoading(message: "Obteniendo recargas...");
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(children: [_internetError(), _emptyState(), _list()]),
          ),
        );
      }));

  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.refills.length,
        itemBuilder: (BuildContext ctx, int i) {
          return RefillItem(
            refill: controller.refills[i],
            onAccept: (bool? answer) {
              controller.handleAnswerRefill(controller.refills[i], answer);
            },
            onTap: () {},
          );
        });
  }

  Widget _internetError() {
    return Obx(() {
      if (controller.hasConnection.isFalse) {
        return UICardMessage.error(
            message: "Sin conexión a internet",
            subMessage: "Verifica si tu wifi o datos móviles estan encedidos",
            icon: Icons.wifi_off_rounded);
      } else {
        return Container();
      }
    });
  }

  Widget _emptyState() {
    return Obx(() {
      if (!controller.refillsLoading.value && controller.refills.isEmpty) {
        return Column(
          children: [
            UICardMessage.neutral(
                message: "No se tienen recargas registradas",
                subMessage: "Intenta actualizar",
                icon: Icons.sentiment_dissatisfied_rounded),
            UIButton.text(
                color: UIColors.darkColor,
                text: "Actualizar",
                onTap: () {
                  controller.getRefills();
                })
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget _bottom() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: UIButton.flat(
          color: UIColors.green,
          text: "Guardar",
          onTap: () {
            controller.handleSaveRefills();
          },
        ),
      ),
    );
  }
}
