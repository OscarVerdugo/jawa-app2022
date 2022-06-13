import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/route/route_customer_model.dart';
import '../controllers/route_make_sale_controller.dart';

class RouteMakeSaleView extends GetView<RouteMakeSaleController> {
  final RouteCustomerModel customer = Get.arguments['customer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venta'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RouteMakeSaleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
