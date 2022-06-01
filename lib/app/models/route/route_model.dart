import 'dart:convert';

import 'package:jawa_app/app/models/product/price_group_model.dart';
import 'package:jawa_app/app/models/route/branch_model.dart';
import 'package:jawa_app/app/models/route/daily_route_model.dart';
import 'package:jawa_app/app/models/route/vehicle_model.dart';

class RouteModel {
  RouteModel({
    required this.idRuta,
    required this.kilometrajeInicial,
    required this.dia,
    this.horaInicio,
    required this.sucursal,
    required this.rutaDiaria,
    required this.vehiculo,
    required this.gruposPrecios,
  });

  final int? idRuta;
  final int kilometrajeInicial;
  final DateTime dia;
  DateTime? horaInicio;
  final BranchModel sucursal;
  final DailyRouteModel? rutaDiaria;
  VehicleModel? vehiculo;
  final List<PriceGroupModel> gruposPrecios;

  factory RouteModel.fromJson(String str) =>
      RouteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RouteModel.fromMap(Map<String, dynamic> json) => RouteModel(
        idRuta: json["id_Ruta"] ?? 0,
        kilometrajeInicial: json["kilometraje_Inicial"] ?? 0,
        dia: DateTime.parse(json["dia"]),
        horaInicio: json['hora_Inicio'] != null
            ? DateTime.parse(json["hora_Inicio"])
            : null,
        sucursal: BranchModel.fromMap(json["sucursal"]),
        rutaDiaria: json["ruta_Diaria"] != null
            ? DailyRouteModel.fromMap(json["ruta_Diaria"])
            : null,
        vehiculo: json["vehiculo"] != null
            ? VehicleModel.fromMap(json["vehiculo"])
            : null,
        gruposPrecios: List<PriceGroupModel>.from(
            json["grupos_Precios"].map((x) => PriceGroupModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_Ruta": idRuta,
        "dia": dia.toIso8601String(),
        "hora_Inicio":
            horaInicio != null ? horaInicio!.toIso8601String() : null,
        "kilometraje_Inicial": kilometrajeInicial,
        "sucursal": sucursal.toMap(),
        "ruta_Diaria": rutaDiaria != null ? rutaDiaria!.toMap() : null,
        "vehiculo": vehiculo != null ? vehiculo!.toMap() : null,
        "grupos_Precios":
            List<dynamic>.from(gruposPrecios.map((x) => x.toMap())),
      };

  String get rutaDiariaDesc {
    return rutaDiaria != null ? rutaDiaria!.descripcion : "Asignada";
  }
}
