import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-customers/widgets/route_customer_item.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';
import 'package:jawa_app/app/utils/ui/widgets/loading_ui.dart';
import 'package:jawa_app/app/widgets/side_menu.dart';

import '../controllers/route_customers_controller.dart';

class RouteCustomersView extends GetView<RouteCustomersController> {
  late UIText textStyles;
  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Clientes'),
        centerTitle: true,
        actions: _actionButtons,
      ),
      body: _body(),
    );
  }

  List<Widget> get _actionButtons {
    return [
      IconButton(
          onPressed: controller.handleGoToAddCustomer,
          icon: Icon(Icons.person_add_rounded))
    ];
  }

  SafeArea _body() => SafeArea(child: GetBuilder<RouteCustomersController>(
          builder: (RouteCustomersController controller) {
        if (controller.loading.value) {
          return UILoading(message: "Cargando clientes...");
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [_routeInfo(), _list()]),
          ),
        );
      }));

  Widget _list() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.customers.length,
        itemBuilder: (BuildContext ctx, int i) {
          return RouteCustomerItem(
              customer: controller.customers[i],
              onTap: () {
                controller.handleSelectCustomer(controller.customers[i]);
              },
              textStyles: textStyles);
        });
  }

  Widget _routeInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [_routeProgress(), _routeResume()],
      ),
    );
  }

  Widget _routeProgress() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: UIColors.blue, borderRadius: BorderRadius.circular(10)),
        height: 75,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${controller.visitedCustomesPercentage}%",
                    style: textStyles.h5.copyWith(color: UIColors.white)),
                Icon(Icons.auto_graph_rounded, color: UIColors.white, size: 28)
              ],
            ),
            SizedBox(width: 8),
            Column(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Clientes: ",
                      style: textStyles.badgeDescriptionSm
                          .copyWith(color: UIColors.white)),
                  TextSpan(
                      text: "${controller.customers.length}",
                      style:
                          textStyles.itemTitle.copyWith(color: UIColors.white))
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Visitados: ",
                      style: textStyles.badgeDescriptionSm
                          .copyWith(color: UIColors.white)),
                  TextSpan(
                      text: "${controller.visitedCustomersLength}",
                      style:
                          textStyles.itemTitle.copyWith(color: UIColors.white))
                ]))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _routeResume() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: UIColors.green, borderRadius: BorderRadius.circular(10)),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${controller.visitedCustomesPercentage}%",
                    style: textStyles.h5.copyWith(color: UIColors.white)),
                Icon(Icons.app_registration_rounded,
                    color: UIColors.white, size: 28)
              ],
            ),
            SizedBox(width: 8),
            Column(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Ventas: ",
                      style: textStyles.badgeDescriptionSm
                          .copyWith(color: UIColors.white)),
                  TextSpan(
                      text: "${controller.customers.length}",
                      style:
                          textStyles.itemTitle.copyWith(color: UIColors.white))
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Cambios: ",
                      style: textStyles.badgeDescriptionSm
                          .copyWith(color: UIColors.white)),
                  TextSpan(
                      text: "${controller.visitedCustomersLength}",
                      style:
                          textStyles.itemTitle.copyWith(color: UIColors.white))
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Mermas: ",
                      style: textStyles.badgeDescriptionSm
                          .copyWith(color: UIColors.white)),
                  TextSpan(
                      text: "${controller.visitedCustomersLength}",
                      style:
                          textStyles.itemTitle.copyWith(color: UIColors.white))
                ]))
              ],
            )
          ],
        ),
      ),
    );
  }
}
