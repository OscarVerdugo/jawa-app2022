import 'dart:convert';

class InventoryProductModel {
  InventoryProductModel(
      {required this.producto,
      required this.presentacion,
      required this.idPresentacion,
      required this.disponible,
      required this.recargado,
      required this.ultimaRecarga});

  final String producto;
  final String presentacion;
  final int idPresentacion;
  final int disponible;
  final int recargado;
  final int ultimaRecarga;

  factory InventoryProductModel.fromJson(String str) =>
      InventoryProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InventoryProductModel.fromMap(Map<String, dynamic> json) =>
      InventoryProductModel(
        producto: json["producto"],
        presentacion: json["presentacion"],
        idPresentacion: json["id_Presentacion"],
        disponible: json["disponible"] ?? 0,
        ultimaRecarga: json["ultima_Recarga"] ?? 0,
        recargado: json["recargado"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "producto": producto,
        "presentacion": presentacion,
        "id_Presentacion": idPresentacion,
        "ultima_Recarga": ultimaRecarga,
        "disponible": disponible,
        "recargado": recargado,
      };
}
