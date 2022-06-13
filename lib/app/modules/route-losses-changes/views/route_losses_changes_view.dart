import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_losses_changes_controller.dart';

class RouteLossesChangesView extends GetView<RouteLossesChangesController> {
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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_internetError(), _list()]),
      ),
    );
  }

  // PENDIENTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
  //EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
  //EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
  // Teoric Inventory, actualizar un inventario temporal en cada registro de movimiento
  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.movements.length,
        itemBuilder: (BuildContext ctx, int i) {
          return Text("$i");
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
            onTap: () {},
          ),
        ),
      );
    }
    return null;
  }
}
