import 'dart:convert';

class PriceModel {
  PriceModel({
    required this.idPresentacion,
    required this.presentacion,
    required this.producto,
    required this.precioUnitario,
  });

  final int idPresentacion;
  final String presentacion;
  final String producto;
  final double precioUnitario;

  factory PriceModel.fromJson(String str) =>
      PriceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceModel.fromMap(Map<String, dynamic> json) => PriceModel(
        idPresentacion: json["id_Presentacion"],
        presentacion: json["presentacion"],
        producto: json["producto"],
        precioUnitario: json["precio_Unitario"],
      );

  Map<String, dynamic> toMap() => {
        "id_Presentacion": idPresentacion,
        "presentacion": presentacion,
        "producto": producto,
        "precio_Unitario": precioUnitario,
      };
}
