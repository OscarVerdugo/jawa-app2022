import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-losses-changes/widgets/product_movement_item.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_losses_changes_controller.dart';

class RouteLossesChangesView extends GetView<RouteLossesChangesController> {
  late UIText textStyles;

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return WillPopScope(
      onWillPop: controller.handleBack,
      child: GetBuilder<RouteLossesChangesController>(
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
      }),
    );
  }

  Widget _body() {
    if (controller.loading.value) {
      return UILoading(message: "Cargando productos...");
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _customerInfo(),
          SizedBox(height: 8),
          _subHeader(),
          _emptyState(),
          _internetError(),
          _list(),
          _add()
        ]),
      ),
    );
  }

  Widget _customerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cliente", style: textStyles.badgeDescriptionSm),
        Text(controller.customer.cliente, style: textStyles.h5)
      ],
    );
  }

  Widget _emptyState() {
    if (controller.movements.isEmpty) {
      return UICardMessage(
          message:
              "Aún no registras ${controller.type == "MER" ? "mermas" : "cambios"}",
          icon: Icons.add_circle_rounded,
          color: UIColors.darkColor);
    } else {
      return Container();
    }
  }

  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.movements.length,
        itemBuilder: (BuildContext ctx, int i) {
          return ProductMovementItem(
              movement: controller.movements[i],
              onTap: () {
                controller.handleSelectMovement(controller.movements[i], i);
              },
              toGive: controller.getProductDescription(
                  controller.movements[i].idPresentacion),
              toReceive: controller.getProductDescription(
                  controller.movements[i].idPresentacionReemplazada!));
        });
  }

  Widget _add() {
    return UIButton.text(
        color: UIColors.darkColor75,
        text: "Agregar",
        onTap: () {
          controller.handleChooseToReceive();
        });
  }

  Widget _subHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            "Entregado",
            style: textStyles.inputText,
          ),
        ),
        Icon(Icons.compare_arrows_rounded,
            size: 24, color: UIColors.darkColor75),
        Flexible(
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Recibido",
              style: textStyles.inputText,
            ),
          ),
        )
      ]),
    );
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
    if (controller.movements.isNotEmpty) {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: UIButton.flat(
            loading: controller.loadingSave.value,
            color: UIColors.green,
            text: "Guardar",
            onTap: () {
              controller.handleSave();
            },
          ),
        ),
      );
    }
    return null;
  }
}
