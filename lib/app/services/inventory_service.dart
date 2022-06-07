import '../models/product/product_refill_model.dart';
import 'http_service.dart';

import '../models/http/res_model.dart';
import 'package:jawa_app/app/models/product/inventory_product_model.dart';

class InventoryService {
  Future<HttpResponse<List<InventoryProductModel>>> getInventory(
      {required int routeId}) async {
    try {
      HttpResponse<List<InventoryProductModel>> response =
          await HttpService.get<List<InventoryProductModel>>(
              method: "rutas/InventarioRuta/$routeId", dataOrigin: "lst");
      if (response.rawData != null) {
        response.data = List<InventoryProductModel>.from(
            response.rawData.map((x) => InventoryProductModel.fromMap(x)));
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }

  Future<HttpResponse<List<ProductRefillModel>>> getRefills(
      {required int routeId}) async {
    try {
      HttpResponse<List<ProductRefillModel>> response =
          await HttpService.get<List<ProductRefillModel>>(
              method: "rutas/RecargasRuta/$routeId", dataOrigin: "lst");
      if (response.rawData != null) {
        response.data = List<ProductRefillModel>.from(
            response.rawData.map((x) => ProductRefillModel.fromMap(x)));
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }
}
