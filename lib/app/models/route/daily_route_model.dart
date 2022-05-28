import 'dart:convert';

class DailyRouteModel {
  DailyRouteModel({
    required this.idRutaDiaria,
    required this.descripcion,
  });

  final int idRutaDiaria;
  final String descripcion;

  factory DailyRouteModel.fromJson(String str) =>
      DailyRouteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyRouteModel.fromMap(Map<String, dynamic> json) => DailyRouteModel(
        idRutaDiaria: json["id_Ruta_Diaria"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "id_Ruta_Diaria": idRutaDiaria,
        "descripcion": descripcion,
      };
}
