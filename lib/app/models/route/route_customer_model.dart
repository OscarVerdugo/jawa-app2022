import 'dart:convert';

import 'package:jawa_app/app/models/product/promotion_model.dart';
import 'package:jawa_app/app/models/route/assigned_note_model.dart';

class RouteCustomerModel {
  RouteCustomerModel(
      {required this.idRutaCliente,
      required this.idCliente,
      required this.cliente,
      this.motivoVisita,
      required this.tipoAsignacion,
      this.atendio,
      this.observacion,
      this.comentarios,
      required this.notasAsignadas,
      required this.idGrupoPrecios,
      required this.factura,
      this.nombreEncargado,
      this.telefono,
      this.telefonoEncargado,
      this.promocion,
      this.horaVisita});

  final int idRutaCliente;
  final int idCliente;
  final String cliente;
  String? motivoVisita;
  final String tipoAsignacion;
  String? atendio;
  String? observacion;
  String? comentarios;
  final String? telefono;
  final String? telefonoEncargado;
  final String? nombreEncargado;
  DateTime? horaVisita;
  final bool factura;
  final List<AssignedNoteModel> notasAsignadas;
  final int idGrupoPrecios;
  PromotionModel? promocion;

  factory RouteCustomerModel.fromJson(String str) =>
      RouteCustomerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RouteCustomerModel.fromMap(Map<String, dynamic> json) =>
      RouteCustomerModel(
        idRutaCliente: json["id_Ruta_Cliente"],
        idCliente: json["id_Cliente"],
        cliente: json["cliente"],
        motivoVisita: json["motivo_Visita"],
        tipoAsignacion: json["tipo_Asignacion"],
        atendio: json["atendio"],
        telefono: json["telefono"],
        horaVisita: json['hora_Visita'] != null
            ? DateTime.parse(json["hora_Visita"])
            : null,
        telefonoEncargado: json["telefono_Encargado"],
        factura: json["factura"],
        observacion: json["observacion"],
        comentarios: json["comentarios"],
        notasAsignadas: List<AssignedNoteModel>.from(
            json["notas_Asignadas"].map((x) => AssignedNoteModel.fromMap(x))),
        idGrupoPrecios: json["id_Grupo_Precios"],
        promocion: json["promocion"] != null
            ? PromotionModel.fromMap(json["promocion"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id_Ruta_Cliente": idRutaCliente,
        "id_Cliente": idCliente,
        "cliente": cliente,
        "motivo_Visita": motivoVisita,
        "tipo_Asignacion": tipoAsignacion,
        "atendio": atendio,
        "observacion": observacion,
        "hora_Visita":
            horaVisita != null ? horaVisita!.toIso8601String() : null,
        "comentarios": comentarios,
        "notas_Asignadas":
            List<dynamic>.from(notasAsignadas.map((x) => x.toMap())),
        "id_Grupo_Precios": idGrupoPrecios,
        "promocion": promocion != null ? promocion!.toMap() : null,
      };
}
