import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  Connection._internal();
  static final Connection _singleton = Connection._internal();
  static Connection getInstance() => _singleton;

  bool hasConnection = false;

  Stream<bool> get onConnectionChange => onChangeConnectionController.stream;

  StreamController<bool> onChangeConnectionController =
      StreamController.broadcast();
  final Connectivity _connectivity = Connectivity();
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      onChangeConnectionController.add(hasConnection);
    }

    return hasConnection;
  }

  void dispose() {
    onChangeConnectionController.close();
  }
}
