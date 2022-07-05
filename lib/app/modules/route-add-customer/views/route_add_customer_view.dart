import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-add-customer/widgets/customer_item.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/route_add_customer_controller.dart';

class RouteAddCustomerView extends GetView<RouteAddCustomerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RouteAddCustomerController>(
        builder: (RouteAddCustomerController ctlr) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Agregar un cliente a la ruta'), centerTitle: true),
        body: SafeArea(child: _body()),
      );
    });
  }

  Widget _body() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      controller: controller.scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(children: [
          _internetError(),
          _searchBar(),
          _emptyState(),
          _list(),
          _searchLoading(),
        ]),
      ),
    );
  }

  Widget _searchBar() {
    return UISearch(
        onSearch: (String text) {
          controller.loadCustomersWithSearch(text);
        },
        controller: controller.searchController,
        placeholder: "Nombre del cliente");
  }

  Widget _list() {
    if (controller.loading.value || controller.addLoading.value) {
      return Container(
          height: Get.height / 2,
          child: UILoading(
              message: controller.loading.value
                  ? "Obteniendo clientes..."
                  : "Cargando..."));
    }
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.customers.length,
        itemBuilder: (BuildContext ctx, int i) {
          return CustomerItem(
              customer: controller.customers[i],
              onTap: () {
                controller.handleAddCustomerToRoute(controller.customers[i]);
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

  Widget _searchLoading() {
    if (controller.searchLoading.value) {
      return UICardLoading();
    } else {
      return Container();
    }
  }

  Widget _emptyState() {
    return Obx(() {
      if (!controller.loading.value && controller.customers.isEmpty) {
        return Column(
          children: [
            UICardMessage.neutral(
                message:
                    "No se encontraron clientes que coincidan con lo buscado",
                subMessage: "Intenta con otro nombre",
                icon: Icons.sentiment_dissatisfied_rounded),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
