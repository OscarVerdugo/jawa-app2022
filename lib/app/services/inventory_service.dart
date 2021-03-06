import 'http_service.dart';

import '../models/product/product_refill_model.dart';
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

  Future<HttpResponse> respondToRefill(
      {required List<Map<String, dynamic>> responses}) async {
    try {
      HttpResponse response = await HttpService.post(
          method: "rutas/ResponderRecarga",
          dataOrigin: "success",
          data: {"lst": responses});
      print(response.rawData);
      if (response.rawData != null) {
        response.data = response.rawData;
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }

  Future<HttpResponse> requestProducts(
      {required List<Map<String, dynamic>> responses}) async {
    try {
      HttpResponse response = await HttpService.post(
          method: "rutas/AgregarMovimientoInventario",
          dataOrigin: "success",
          data: {"lst": responses});
      print(response.rawData);
      if (response.rawData != null) {
        response.data = response.rawData;
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }

  Future<HttpResponse> saveProductMovements(
      {required List<Map<String, dynamic>> movements}) async {
    try {
      HttpResponse response = await HttpService.post(
          method: "rutas/AgregarProductoMovimiento",
          dataOrigin: "success",
          data: {"lst": movements});
      print(response.message);
      if (response.rawData != null) {
        response.data = response.rawData;
      }
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }
}
