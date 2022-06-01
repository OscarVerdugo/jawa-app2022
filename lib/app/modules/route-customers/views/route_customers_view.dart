import 'dart:js';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-customers/widgets/route_customer_item.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';
import 'package:jawa_app/app/utils/ui/widgets/loading_ui.dart';

import '../controllers/route_customers_controller.dart';

class RouteCustomersView extends GetView<RouteCustomersController> {
  late UIText textStyles;
  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.test();
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: _body(),
    );
  }

  SafeArea _body() => SafeArea(child: SingleChildScrollView(child: _list()));

  Widget _list() {
    return GetBuilder<RouteCustomersController>(
        builder: (RouteCustomersController controller) {
      if (controller.loading.value) {
        return UILoading(message: "Cargando clientes...");
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.customers.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext ctx, int i) {
              return RouteCustomerItem(
                  customer: controller.customers[i],
                  onTap: () {
                    controller.handleSelectCustomer(controller.customers[i]);
                  },
                  textStyles: textStyles);
            }),
      );
    });
  }
}
