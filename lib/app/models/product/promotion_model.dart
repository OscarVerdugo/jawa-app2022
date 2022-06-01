import 'dart:convert';

class PromotionModel {
  PromotionModel({
    required this.idGrupoPromocion,
    required this.piezasCompra,
    required this.piezasRegalo,
  });

  final int idGrupoPromocion;
  final int piezasCompra;
  final int piezasRegalo;

  factory PromotionModel.fromJson(String str) =>
      PromotionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotionModel.fromMap(Map<String, dynamic> json) => PromotionModel(
        idGrupoPromocion: json["id_Grupo_Promocion"],
        piezasCompra: json["piezas_Compra"],
        piezasRegalo: json["piezas_Regalo"],
      );

  Map<String, dynamic> toMap() => {
        "id_Grupo_Promocion": idGrupoPromocion,
        "piezas_Compra": piezasCompra,
        "piezas_Regalo": piezasRegalo,
      };
}
