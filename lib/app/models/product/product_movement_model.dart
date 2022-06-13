import 'dart:convert';

import 'package:jawa_app/app/models/product/product_model.dart';

class ProductMovementModel {
  ProductMovementModel({
    this.idMovimiento,
    required this.idRuta,
    required this.idRutaCliente,
    required this.idPresentacion,
    required this.precioUnitario,
    required this.cantidad,
    required this.idPresentacionReemplazada,
    required this.precioUnitarioReemplazada,
    required this.tipoMovimiento,
  });

  int? idMovimiento;
  int idRuta;
  final int idRutaCliente;
  final int idPresentacion;
  final double precioUnitario;
  int cantidad;
  int? idPresentacionReemplazada;
  double? precioUnitarioReemplazada;
  String tipoMovimiento;

  factory ProductMovementModel.fromJson(String str) =>
      ProductMovementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductMovementModel.fromMap(Map<String, dynamic> json) =>
      ProductMovementModel(
        idMovimiento: json["id_Movimiento"],
        idRuta: json["id_Ruta"],
        idRutaCliente: json["id_Ruta_Cliente"],
        idPresentacion: json["id_Presentacion"],
        precioUnitario: json["precio_Unitario"],
        cantidad: json["cantidad"],
        idPresentacionReemplazada: json["id_Presentacion_Reemplazada"],
        precioUnitarioReemplazada: json["precio_Unitario_Reemplazada"],
        tipoMovimiento: json["tipo_Movimiento"],
      );

  factory ProductMovementModel.fromLossChange(
      {required ProductModel product,
      required ProductModel toReceive,
      required String type,
      required int idRoute,
      required int idRouteCustomer}) {
    return ProductMovementModel(
      idRuta: idRoute,
      idRutaCliente: idRouteCustomer,
      idPresentacion: product.idPresentacion,
      precioUnitario: product.precio ?? 0.0,
      cantidad: product.cantidad!,
      idPresentacionReemplazada: toReceive.idPresentacion,
      precioUnitarioReemplazada: toReceive.precio ?? 0.0,
      tipoMovimiento: type,
    );
  }

  Map<String, dynamic> toMap() => {
        "id_Movimiento": idMovimiento,
        "id_Ruta": idRuta,
        "id_Ruta_Cliente": idRutaCliente,
        "id_Presentacion": idPresentacion,
        "precio_Unitario": precioUnitario,
        "cantidad": cantidad,
        "id_Presentacion_Reemplazada": idPresentacionReemplazada,
        "precio_Unitario_Reemplazada": precioUnitarioReemplazada,
        "tipo_Movimiento": tipoMovimiento,
      };
}
