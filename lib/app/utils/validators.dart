import 'utils.dart';

class Validators {
  static String? username(String? value) {
    if (value == null || value.isEmpty) return "Ingrese un usuario";
    if (RE.username.hasMatch(value)) {
      return null;
    }
    return "Verifique su usuario";
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return "Ingrese su contraseña";
    if (RE.password.hasMatch(value)) {
      return null;
    }
    return "Verifique su contraseña";
  }
}
