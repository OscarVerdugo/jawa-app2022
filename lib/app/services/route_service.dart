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
        print(response.rawData);
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
          method: "rutas/seleccionarvehiculo",
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
}
