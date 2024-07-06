import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionHelper {
  // Function to check if the device is connected to the internet
  static Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      return true; 
    }

    return false; 
  }
}
