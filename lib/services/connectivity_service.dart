import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService() {
    checkInternetConn();
  }

  Connectivity connectivity = Connectivity();

  bool hasConn = false;

  ConnectivityResult? connectionMedium;

  StreamController<bool> connController = StreamController.broadcast();
  Stream<bool> get connChange => connController.stream;

  Future<bool> checkInternetConn() async {
    bool previousConnection = hasConn;
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConn = true;
      } else {
        hasConn = false;
      }
    } on SocketException catch (_) {
      hasConn = false;
    }

    if (previousConnection != hasConn) {
      connController.add(hasConn);
    }

    return hasConn;
  }
}
