import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/controllers/global_controller.dart';
import 'package:jawa_app/app/modules/lists-pages/vehicles-list/widgets/vehicle-item.dart';
import 'package:jawa_app/app/routes/app_pages.dart';
import 'package:jawa_app/app/utils/utils.dart';

import '../../../utils/ui/ui.dart';
import '../controllers/initialize_route_controller.dart';

class InitializeRouteView extends GetView<InitializeRouteController> {
  late UIText textStyles;

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Buen día ${controller.user.value!.name}!')),
        centerTitle: true,
      ),
      bottomNavigationBar: _bottomBar(),
      body: Obx(() {
        if (controller.globalCtrl.loadingRoute.value &&
            controller.globalCtrl.initialLoading) {
          return _loading();
        } else {
          return _body();
        }
      }),
    );
  }

  Widget _bottomBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: UIButton.text(
          color: UIColors.red,
          text: "Regresar",
          onTap: controller.handleLogout,
        ),
      ),
    );
  }

  Widget _body() {
    return GetBuilder<GlobalController>(builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: controller.globalCtrl.route.value == null
                ? _withoutRoute()
                : _withRoute(),
          ),
        ),
      );
    });
  }

  Column _withRoute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Tu ruta del día es",
            style: textStyles.h5.copyWith(color: UIColors.darkColor60)),
        Text(
          controller.globalCtrl.route.value!.rutaDiariaDesc,
          style: textStyles.h4,
        ),
        if (controller.alreadyStarted.value)
          Text("( Ruta iniciada )",
              style: textStyles.h5.copyWith(color: UIColors.blue)),
        SizedBox(height: 24),
        _selectedVehicle(),
        SizedBox(height: 16),
        _mileage(),
        SizedBox(height: 8),
        _selectVehicleButton(),
        SizedBox(height: 8),
        UIButton.flat(
            loading: controller.loading.value,
            onTap: controller.handleStartRoute,
            color: UIColors.blue,
            text: controller.alreadyStarted.value
                ? "Continuar ruta"
                : "Iniciar ruta")
      ],
    );
  }

  Widget _withoutRoute() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text("Tu ruta del día es",
          style: textStyles.h5.copyWith(color: UIColors.darkColor60)),
      Text(
        "Sin ruta asignada",
        style: textStyles.h4,
      ),
      SizedBox(height: 16),
      Text(
        "Aún no tienes asignada una ruta para el día de hoy, puedes continuar en la aplicación sin ruta o esperar a que te asignen una.",
        style: textStyles.message,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 32),
      UIButton.text(
        color: UIColors.darkColor,
        text: "Continuar sin ruta",
        onTap: () {},
      ),
      SizedBox(height: 16),
      Obx(() {
        return UIButton.text(
          color: UIColors.darkColor75,
          text: "Actualizar",
          loading: controller.globalCtrl.loadingRoute.value,
          onTap: controller.handleRefetchRoute,
        );
      })
    ]);
  }

  Widget _mileage() {
    return Form(
        key: controller.formKey,
        child: UITextField(
            readonly: controller.alreadyStarted.value,
            validator: Validators.mileage,
            inputType: TextInputType.number,
            controller: controller.initialMileageController,
            label: "Kilometraje inicial"));
  }

  Obx _selectedVehicle() {
    return Obx(() {
      if (controller.vehicle.value != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vehículo seleccionado", style: textStyles.inputTextLabel),
            SizedBox(height: 4),
            VehicleItem(
                textStyles: textStyles,
                vehicle: controller.vehicle.value!,
                onTap: null)
          ],
        );
      } else {
        return _withoutVehicle();
      }
    });
  }

  Material _withoutVehicle() {
    return Material(
      color:
          controller.vehicleError.value ? UIColors.red : UIColors.darkColor10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: 50,
        child: InkWell(
          onTap: controller.handleGoToSelectVehicle,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
                child: Text(
              "Sin vehículo seleccionado",
              style: textStyles.button.copyWith(
                  color: controller.vehicleError.value
                      ? UIColors.white
                      : UIColors.darkColor90),
            )),
          ),
        ),
      ),
    );
  }

  Obx _selectVehicleButton() {
    return Obx(() {
      if (controller.alreadyStarted.value) return Container();
      return UIButton.text(
        color: UIColors.darkColor,
        text: controller.vehicle.value != null
            ? "Cambiar vehículo"
            : "Seleccionar vehiculo",
        onTap: controller.handleGoToSelectVehicle,
      );
    });
  }

  Widget _loading() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
                color: UIColors.blue, strokeWidth: 5)),
        SizedBox(height: 16),
        Text(controller.globalCtrl.loadingRouteMessage.value ?? "Cargando...",
            style: textStyles.titleSm
                .copyWith(color: UIColors.darkColor.withOpacity(0.8)))
      ]),
    );
  }
}
