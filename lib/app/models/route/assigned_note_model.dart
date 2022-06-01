import 'dart:convert';

class AssignedNoteModel {
  AssignedNoteModel({
    required this.idVenta,
    required this.folio,
    required this.pagoInicial,
    required this.importe,
    required this.importePendiente,
  });

  final int idVenta;
  final String folio;
  final double pagoInicial;
  final double importe;
  final double importePendiente;

  factory AssignedNoteModel.fromJson(String str) =>
      AssignedNoteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignedNoteModel.fromMap(Map<String, dynamic> json) =>
      AssignedNoteModel(
        idVenta: json["id_Venta"],
        folio: json["folio"],
        pagoInicial: json["pago_Inicial"],
        importe: json["importe"],
        importePendiente: json["importe_Pendiente"],
      );

  Map<String, dynamic> toMap() => {
        "id_Venta": idVenta,
        "folio": folio,
        "pago_Inicial": pagoInicial,
        "importe": importe,
        "importe_Pendiente": importePendiente,
      };
}
