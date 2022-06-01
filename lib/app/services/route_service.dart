import 'package:jawa_app/app/models/route/route_customer_model.dart';
import 'package:jawa_app/app/models/route/route_model.dart';

import '../models/http/res_model.dart';
import 'http_service.dart';

class RouteService {
  Future<HttpResponse<RouteModel>> getRouteInfo(
      {required DateTime date}) async {
    try {
      HttpResponse<RouteModel> response = await HttpService.post<RouteModel>(
          method: "rutas/informacionruta",
          data: {"dia": date.toIso8601String()},
          dataOrigin: "data");
      if (response.rawData != null) {
        response.data = RouteModel.fromMap(response.rawData);
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }

  Future<HttpResponse> chooseVehicle(
      {required int routeId,
      required int vehicleId,
      required int initialMileage}) async {
    try {
      HttpResponse response = await HttpService.post(
          method: "rutas/comenzarruta",
          data: {
            "id_Ruta": routeId,
            "id_Vehiculo": vehicleId,
            "kilometraje_Inicial": initialMileage
          },
          dataOrigin: "data");

      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }

  Future<HttpResponse<List<RouteCustomerModel>>> getRouteCustomers(
      {required int routeId}) async {
    try {
      HttpResponse<List<RouteCustomerModel>> response =
          await HttpService.get<List<RouteCustomerModel>>(
              method: "rutas/clientesruta/$routeId", dataOrigin: "lst");
      if (response.rawData != null) {
        response.data = List<RouteCustomerModel>.from(
            response.rawData.map((x) => RouteCustomerModel.fromMap(x)));
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }
}
