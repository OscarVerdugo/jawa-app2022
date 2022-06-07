import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/models/product/inventory_product_model.dart';
import 'package:jawa_app/app/modules/route-inventory/widgets/product_item.dart';
import 'package:jawa_app/app/utils/ui/widgets/option_ui.dart';
import 'package:jawa_app/app/widgets/widgets.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_inventory_controller.dart';

class RouteInventoryView extends GetView<RouteInventoryController> {
  late UIText textStyles;

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Inventario'),
        centerTitle: true,
        actions: [_optionsButton()],
      ),
      body: _body(),
    );
  }

  SafeArea _body() => SafeArea(child: GetBuilder<RouteInventoryController>(
          builder: (RouteInventoryController builder) {
        if (controller.intentoryLoading.value) {
          return UILoading(message: "Cargando inventario...");
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(children: [_internetError(), _emptyState(), _list()]),
          ),
        );
      }));

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
      if (!controller.intentoryLoading.value && controller.products.isEmpty) {
        return Column(
          children: [
            UICardMessage.neutral(
                message: "No se tiene inventario asignado",
                subMessage: "Intenta actualizar o ve al apartado de recargas",
                icon: Icons.sentiment_dissatisfied_rounded),
            UIButton.text(
                color: UIColors.darkColor,
                text: "Actualizar",
                onTap: () {
                  controller.getInventory();
                })
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget _optionsButton() {
    return IconButton(
        onPressed: controller.handleOpenMenu,
        icon: Icon(Icons.more_horiz_rounded, color: UIColors.darkColor));
  }

  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.products.length,
        itemBuilder: (BuildContext ctx, int i) {
          return ProductItem(product: controller.products[i]);
        });
  }
}
