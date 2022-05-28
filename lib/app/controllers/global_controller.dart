import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jawa_app/app/models/http/res_model.dart';
import 'package:jawa_app/app/models/route/vehicle_model.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:get/get.dart';
//services
import 'package:jawa_app/app/services/route_service.dart';
//utils
import '../utils/utils.dart';
import '../routes/app_pages.dart';
//models
import '../models/auth/user_model.dart';
import 'package:jawa_app/app/models/route/route_model.dart';

class GlobalController extends GetxController {
  var user = Rxn<UserModel>();
  var route = Rxn<RouteModel>();

  final loadingRoute = RxBool(false);
  var initialLoading = true;
  final loadingRouteMessage = RxnString();

  final storage = FlutterSecureStorage();

  final routeService = RouteService();

  final hasConnection = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    initSession();
    Connection connection = Connection.getInstance();
    connection.onConnectionChange.listen(onChangeConnection);
    hasConnection.value = await connection.checkConnection();
  }

  Future<void> initSession() async {
    String? token = await this.token;
    if (token == null) return;
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      if (payload['id'] != null && payload['exp'] != null) {
        DateTime exp =
            DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        if (exp.isAfter(DateTime.now())) {
          user.value = UserModel.fromMap(payload);
          return;
        }
        return;
      }
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<void> initRoute() async {
    loadingRoute.value = true;
    loadingRouteMessage.value = "Verificando ruta previa...";
    var storedRoute = await storage.read(key: "current-route");
    if (storedRoute != null) {
      RouteModel route = RouteModel.fromJson(storedRoute);
      if (DateTime.now().isAfter(route.dia)) {
        await storage.delete(key: "current-route");
        getRoute();
      } else {
        initialLoading = false;
        loadingRoute.value = false;
        this.route.value = route;
      }
    } else {
      getRoute();
    }
  }

  Future<void> getRoute() async {
    loadingRoute.value = true;
    loadingRouteMessage.value = "Obteniendo ruta...";
    if (hasConnection.value) {
      final res = await routeService.getRouteInfo(date: DateTime.now());
      if (res.success && res.data != null) {
        route.value = res.data;
        await storage.write(key: "current-route", value: res.data!.toJson());
      } else {
        print("RESULT FAILURE");
      }
      initialLoading = false;
      loadingRoute.value = false;
    }
    update();
  }

  Future<HttpResponse> chooseVehicle(
      VehicleModel vehicle, int initialMileage) async {
    if (hasConnection.value) {
      final res = await routeService.chooseVehicle(
          routeId: route.value!.idRuta!,
          vehicleId: vehicle.idVehiculo,
          initialMileage: initialMileage);
      if (res.success) {
        route.value!.vehiculo = vehicle;
        await storage.write(key: "current-route", value: route.value!.toJson());
      } else {
        print("RESULT FAILURE");
      }
      update();
      return res;
    } else {
      return HttpResponse.fromError("Sin conexión a internet", 0);
    }
  }

  Future<String?> get token async {
    return await storage.read(key: 'access-token');
  }

  Future<bool> verify() async {
    String? token = await this.token;
    if (token == null) return false;

    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      if (payload['id'] != null && payload['exp'] != null) {
        DateTime exp =
            DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        if (exp.isAfter(DateTime.now())) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  saveSession(String token) async {
    print(token);
    await storage.write(key: 'access-token', value: token);
    await initSession();
  }

  logout() async {
    await storage.delete(key: 'access-token');
    user = Rxn<UserModel>();
    route = Rxn<RouteModel>();
    Get.offAllNamed(Routes.SIGNIN);
  }

  void onChangeConnection(bool hasConnection) {
    this.hasConnection.value = hasConnection;
    if (!hasConnection) {
      // displayMessage.value = true;
      // message.value = "Necesitas conexión a internet para iniciar";
    } else {
      // displayMessage.value = false;
      // message.value = null;
    }
  }
}
