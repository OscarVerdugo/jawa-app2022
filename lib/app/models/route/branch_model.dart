import 'dart:convert';

class BranchModel {
  BranchModel({
    required this.idSucursal,
    required this.descripcion,
  });

  final int idSucursal;
  final String descripcion;

  factory BranchModel.fromJson(String str) =>
      BranchModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BranchModel.fromMap(Map<String, dynamic> json) => BranchModel(
        idSucursal: json["id_Sucursal"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "id_Sucursal": idSucursal,
        "descripcion": descripcion,
      };
}
