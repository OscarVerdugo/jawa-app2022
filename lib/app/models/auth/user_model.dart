import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.nbf,
    required this.exp,
    required this.iat,
  });

  final int id;
  final String name;
  final int nbf;
  final int exp;
  final int iat;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: int.parse(json["id"]),
        name: json["name"],
        nbf: json["nbf"],
        exp: json["exp"],
        iat: json["iat"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "nbf": nbf,
        "exp": exp,
        "iat": iat,
      };
}
