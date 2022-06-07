import 'dart:convert';

class VehicleModel {
  VehicleModel({
    required this.idVehiculo,
    required this.marca,
    required this.modelo,
    required this.placas,
    required this.color,
    required this.enUso,
  });

  final int idVehiculo;
  final String? marca;
  final String? modelo;
  final String? placas;
  final String? color;
  final bool enUso;

  factory VehicleModel.fromJson(String str) =>
      VehicleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleModel.fromMap(Map<String, dynamic> json) => VehicleModel(
        idVehiculo: json["id_Vehiculo"],
        marca: json["marca"] ?? "Sin marca",
        modelo: json["modelo"] ?? "Sin modelo",
        placas: json["placas"] ?? "Sin placas",
        color: json["color"] ?? "000000",
        enUso: json["en_Uso"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id_Vehiculo": idVehiculo,
        "marca": marca,
        "modelo": modelo,
        "placas": placas,
        "color": color,
        "en_Uso": enUso,
      };
  String? get description {
    return "$marca $modelo";
  }
}
