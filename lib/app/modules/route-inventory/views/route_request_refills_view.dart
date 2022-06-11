import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-inventory/widgets/refill_item.dart';
import 'package:jawa_app/app/utils/constants.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_inventory_controller.dart';
import '../widgets/requestable_product_item.dart';

class RouteRequestRefillsView extends GetView<RouteInventoryController> {
  late UIText textStyles;
  var isReturn = false;
  RouteRequestRefillsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    if (Get.arguments != null && Get.arguments['isReturn'] != null) {
      isReturn = Get.arguments['isReturn'];
    }
    return GetBuilder<RouteInventoryController>(
        builder: (RouteInventoryController ctlr) {
      return Scaffold(
        appBar: AppBar(
            title: Text(isReturn ? "Retornar producto" : 'Solicitar recarga'),
            centerTitle: true),
        bottomNavigationBar: _bottom(),
        body: SafeArea(child: _body()),
      );
    });
  }

  Widget _body() {
    if (controller.productsLoading.value) {
      return UILoading(message: "Obteniendo productos...");
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(children: [_internetError(), _list()]),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.products.length,
        itemBuilder: (BuildContext ctx, int i) {
          return RequestableProductItem(
              isReturn: isReturn,
              product: controller.products[i],
              onTap: () {
                controller.handleRequestProductQuantity(
                    controller.products[i], isReturn);
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
    if (controller.products.where((r) => r.cantidad != null).isEmpty) {
      return null;
    }
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: UIButton.flat(
          loading: controller.respondRefillsLoading.value,
          color: UIColors.green,
          text: "Enviar",
          onTap: () {
            controller.handleSaveRequests(isReturn: isReturn);
          },
        ),
      ),
    );
  }
}
