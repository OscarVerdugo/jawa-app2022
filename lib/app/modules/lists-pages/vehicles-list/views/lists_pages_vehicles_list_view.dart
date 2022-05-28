import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/modules/lists-pages/vehicles-list/widgets/vehicle-item.dart';
import 'package:jawa_app/app/utils/ui/widgets/loading_ui.dart';

import '../../../../utils/ui/ui.dart';
import '../controllers/vehicles_list_controller.dart';

class VehiclesListView extends GetView<VehiclesListController> {
  late UIText textStyles;

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un vehículo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _body(),
      ),
    );
  }

  Widget _body() => GetBuilder<VehiclesListController>(builder: (controller) {
        if (controller.loading.value) return UILoading();
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.vehicles.length,
            itemBuilder: (BuildContext context, int index) {
              return VehicleItem(
                  textStyles: textStyles,
                  vehicle: controller.vehicles[index],
                  onTap: () {
                    controller.handleSelectVehicle(controller.vehicles[index]);
                  });
            });
      });
}
