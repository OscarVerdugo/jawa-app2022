import 'dart:convert';

class ProductRefillModel {
  ProductRefillModel({
    required this.idPresentacion,
    required this.producto,
    required this.presentacion,
    required this.cantidad,
    required this.origen,
    required this.usuarioRegistro,
    required this.fechaRegistro,
    required this.usuarioRespuesta,
    required this.fechaRespuesta,
    required this.estatus,
  });

  final int idPresentacion;
  final String producto;
  final String presentacion;
  final int cantidad;
  final String origen;
  final String usuarioRegistro;
  final DateTime fechaRegistro;
  final String? usuarioRespuesta;
  final DateTime? fechaRespuesta;
  final String estatus;
  bool? aceptado;

  factory ProductRefillModel.fromJson(String str) =>
      ProductRefillModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductRefillModel.fromMap(Map<String, dynamic> json) =>
      ProductRefillModel(
        idPresentacion: json["id_Presentacion"] ?? 0,
        producto: json["producto"],
        presentacion: json["presentacion"],
        origen: json["origen"],
        cantidad: json["cantidad"] ?? 0,
        usuarioRegistro: json["usuario_Registro"],
        fechaRegistro: DateTime.parse(json["fecha_Registro"]),
        usuarioRespuesta: json["usuario_Respuesta"],
        fechaRespuesta: json["fecha_Respuesta"] != null
            ? DateTime.parse(json["fecha_Respuesta"])
            : null,
        estatus: json["estatus"],
      );

  Map<String, dynamic> toMap() => {
        "id_Presentacion": idPresentacion,
        "producto": producto,
        "presentacion": presentacion,
        "cantidad": cantidad,
        "origen": origen,
        "usuario_Registro": usuarioRegistro,
        "fecha_Registro": fechaRegistro.toIso8601String(),
        "usuario_Respuesta": usuarioRespuesta,
        "fecha_Respuesta":
            fechaRespuesta != null ? fechaRespuesta!.toIso8601String() : null,
        "estatus": estatus,
        "aceptado": aceptado
      };
}
