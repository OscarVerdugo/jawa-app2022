import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/route_customers_controller.dart';

class RouteCustomersView extends GetView<RouteCustomersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RouteCustomersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RouteCustomersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
