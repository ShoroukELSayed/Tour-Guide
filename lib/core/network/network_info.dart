import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  Future<bool> get isConnected async {
    final res = await Connectivity().checkConnectivity();
    return res != ConnectivityResult.none;
  }
}