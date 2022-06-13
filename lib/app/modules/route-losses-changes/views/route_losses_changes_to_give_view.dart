import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-losses-changes/widgets/product_to_give_item.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_losses_changes_controller.dart';

class RouteLossesChangesToGiveView
    extends GetView<RouteLossesChangesController> {
  late UIText textStyles;

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return GetBuilder<RouteLossesChangesController>(
        builder: (RouteLossesChangesController ctrl) {
      return Scaffold(
        bottomNavigationBar: _bottom(),
        appBar: AppBar(
          title: Text(controller.type == "MER"
              ? "Cambiar mermas"
              : "Cambiar productos"),
          centerTitle: true,
        ),
        body: SafeArea(child: _body()),
      );
    });
  }

  Widget _body() {
    if (controller.productsLoading.value) {
      return UILoading(message: "Cargando productos...");
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _internetError(),
          _subHeader("Producto a recibir"),
          _toReceive(),
          _subHeader("Selecciona los productos a dar"),
          _list()
        ]),
      ),
    );
  }

  Widget _toReceive() {
    if (controller.toReceive.value == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(controller.selectedProduct.value!.producto,
                style: textStyles.itemTitle),
            Text(controller.selectedProduct.value!.presentacion,
                style: textStyles.inputText)
          ]),
          Text.rich(TextSpan(children: [
            TextSpan(text: "Recibidos ", style: textStyles.itemInfoSm),
            TextSpan(
                text: "${controller.toReceive.value}",
                style: textStyles.h5.copyWith(color: UIColors.blue))
          ])),
        ],
      ),
    );
  }

  Padding _subHeader(String message) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          message,
          style: textStyles.inputText,
        ),
      );

  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.availableProducts.length,
        itemBuilder: (BuildContext ctx, int i) {
          return ProductToGiveItem(
              product: controller.availableProducts[i],
              onTap: () {
                controller.handleSelectToGive(i);
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

  Widget? _bottom() {
    final alreadySelected = controller.availableProducts
        .fold<int>(0, (sum, p) => (p.cantidad ?? 0) + sum);
    if (alreadySelected == controller.toReceive.value) {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: UIButton.flat(
            color: UIColors.green,
            text: "Guardar",
            onTap: () {
              controller.handleRegistMovement();
            },
          ),
        ),
      );
    }
    return null;
  }
}
