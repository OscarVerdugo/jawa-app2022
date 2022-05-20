import 'package:jawa_app/app/models/http/res_model.dart';

class Data<T> {
  final HttpResponse<T> response;
  T? data;
  Data({required this.response, required this.data});
}
