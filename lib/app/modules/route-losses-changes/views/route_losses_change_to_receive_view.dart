import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-losses-changes/widgets/product_to_receive_item.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_losses_changes_controller.dart';

class RouteLossesChangesToReceiveView
    extends GetView<RouteLossesChangesController> {
  late UIText textStyles;

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            controller.type == "MER" ? "Cambiar mermas" : "Cambiar productos"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  SafeArea _body() => SafeArea(child: GetBuilder<RouteLossesChangesController>(
          builder: (RouteLossesChangesController builder) {
        if (controller.loading.value) {
          return UILoading(message: "Cargando productos...");
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_internetError(), _header(), _list()]),
          ),
        );
      }));

  Padding _header() => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          "Selecciona el producto a recibir",
          style: textStyles.inputText,
        ),
      );

  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.products.length,
        itemBuilder: (BuildContext ctx, int i) {
          return ProductToReceiveItem(
              product: controller.products[i],
              onTap: () {
                controller.handleSelectToReceive(controller.products[i]);
              });
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
}
