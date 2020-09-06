import 'package:connectivity/connectivity.dart';
import 'dart:async';

class InternetService {
  final Connectivity _connectivity = Connectivity();

  initialize() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      checkNetworkStatus();
    });
    return checkNetworkStatus();
  }

  Future<String> checkNetworkStatus() async {
    var connectivityRes = await Connectivity().checkConnectivity();
    if (connectivityRes == ConnectivityResult.mobile ||
        connectivityRes == ConnectivityResult.wifi) {
      return "Online";
    } else {
      return "Offline";
    }
  }
}
