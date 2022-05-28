import '../models/http/res_model.dart';
import 'http_service.dart';

class AuthService {
  Future<HttpResponse<String>> signin(
      {required String username, required String password}) async {
    try {
      HttpResponse<String> response = await HttpService.post<String>(
          method: "usuarios/authenticate",
          data: {"username": username, "password": password},
          dataOrigin: "token");
      response.data = response.rawData;
      return response;
    } catch (e) {
      return HttpResponse.fromError(e.toString(), 0);
    }
  }
}
