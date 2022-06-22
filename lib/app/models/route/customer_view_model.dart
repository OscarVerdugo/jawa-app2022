import 'dart:convert';

class CustomerViewModel {
  CustomerViewModel(
      {required this.idCliente,
      required this.nombre,
      required this.telefono,
      required this.direccion});

  final int idCliente;
  final String nombre;
  String? telefono;
  String? direccion;

  factory CustomerViewModel.fromJson(String str) =>
      CustomerViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerViewModel.fromMap(Map<String, dynamic> json) =>
      CustomerViewModel(
        idCliente: json["id_Cliente"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        direccion: json["direccion"],
      );

  Map<String, dynamic> toMap() => {
        "id_Cliente": idCliente,
        "nombre": nombre,
        "telefono": telefono,
        "direccion": direccion
      };
}
