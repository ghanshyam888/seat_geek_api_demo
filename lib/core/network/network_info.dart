import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._dataConnectionChecker);

  final Connectivity _dataConnectionChecker;

  @override
  Future<bool> get isConnected async {
    var connectivityResult = await (_dataConnectionChecker.checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
