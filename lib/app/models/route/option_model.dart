import 'dart:convert';

class OptionModel {
  OptionModel({
    required this.idOpcion,
    required this.descripcion,
  });

  final int idOpcion;
  final String descripcion;

  factory OptionModel.fromJson(String str) =>
      OptionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OptionModel.fromMap(Map<String, dynamic> json) => OptionModel(
        idOpcion: json["id_Opcion"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "id_Opcion": idOpcion,
        "descripcion": descripcion,
      };
}
