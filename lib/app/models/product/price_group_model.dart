import 'dart:convert';

import 'package:jawa_app/app/models/product/price_model.dart';

class PriceGroupModel {
  PriceGroupModel({
    required this.idGrupoPrecio,
    required this.descripcion,
    required this.precios,
  });

  final int idGrupoPrecio;
  final String descripcion;
  final List<PriceModel> precios;

  factory PriceGroupModel.fromJson(String str) =>
      PriceGroupModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceGroupModel.fromMap(Map<String, dynamic> json) => PriceGroupModel(
        idGrupoPrecio: json["id_Grupo_Precio"],
        descripcion: json["descripcion"],
        precios: List<PriceModel>.from(
            json["precios"].map((x) => PriceModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_Grupo_Precio": idGrupoPrecio,
        "descripcion": descripcion,
        "precios": List<dynamic>.from(precios.map((x) => x.toMap())),
      };
}
