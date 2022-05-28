import 'package:jawa_app/app/models/route/route_model.dart';
import 'package:jawa_app/app/models/route/vehicle_model.dart';

import '../models/http/res_model.dart';
import 'http_service.dart';

class GeneralService {
  Future<HttpResponse<List<VehicleModel>>> getVehicles() async {
    try {
      HttpResponse<List<VehicleModel>> response =
          await HttpService.get<List<VehicleModel>>(
              method: "general/obtenervehiculos", dataOrigin: "lst");
      if (response.rawData != null) {
        response.data = List<VehicleModel>.from(
            response.rawData.map((x) => VehicleModel.fromMap(x)));
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }
}
