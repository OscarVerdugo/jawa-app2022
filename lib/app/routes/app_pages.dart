import 'package:get/get.dart';
import 'package:jawa_app/app/modules/route-inventory/views/route_refills_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/initialize-route/bindings/initialize_route_binding.dart';
import '../modules/initialize-route/views/initialize_route_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/lists-pages/vehicles-list/bindings/vehicles_list_binding.dart';
import '../modules/lists-pages/vehicles-list/views/lists_pages_vehicles_list_view.dart';
import '../modules/route-customers/bindings/route_customers_binding.dart';
import '../modules/route-customers/views/route_customers_view.dart';
import '../modules/route-inventory/bindings/route_inventory_binding.dart';
import '../modules/route-inventory/views/route_inventory_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.ROUTE_CUSTOMERS,
      page: () => RouteCustomersView(),
      binding: RouteCustomersBinding(),
    ),
    GetPage(
      name: _Paths.INITIALIZE_ROUTE,
      page: () => InitializeRouteView(),
      binding: InitializeRouteBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLES_LIST,
      page: () => VehiclesListView(),
      binding: VehiclesListBinding(),
    ),
    GetPage(
      name: _Paths.ROUTE_INVENTORY,
      page: () => RouteInventoryView(),
      binding: RouteInventoryBinding(),
    ),
    GetPage(
      name: _Paths.ROUTE_REFILLS,
      page: () => RouteRefillsView(),
      binding: RouteInventoryBinding(),
    ),
  ];
}
