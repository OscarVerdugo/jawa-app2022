import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.idPresentacion,
    required this.idProducto,
    required this.producto,
    required this.presentacion,
  });

  final int idPresentacion;
  final int idProducto;
  final String producto;
  final String presentacion;
  int? cantidad;
  int disponible = 0;
  final String origen = "RUTA";

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        idPresentacion: json["id_Presentacion"],
        idProducto: json["id_Producto"],
        producto: json["producto"],
        presentacion: json["presentacion"],
      );

  Map<String, dynamic> toMap() => {
        "id_Presentacion": idPresentacion,
        "id_Producto": idProducto,
        "producto": producto,
        "presentacion": presentacion,
      };
  Map<String, dynamic> toRequest(int idRuta) => {
        "id_Presentacion": idPresentacion,
        "cantidad": cantidad,
        "id_Ruta": idRuta,
        "origen": origen
      };
  Map<String, dynamic> toReturn(int idRuta) => {
        "id_Presentacion": idPresentacion,
        "cantidad": (cantidad! * -1),
        "id_Ruta": idRuta,
        "origen": origen
      };
}
