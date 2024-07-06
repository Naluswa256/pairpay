// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sizzle_starter/src/core/network_health_check/bloc/network_bloc.dart';
import 'package:sizzle_starter/src/core/network_health_check/bloc/network_bloc_events.dart'; // Adjust the import according to your project structure

class NetworkHelper {
  static late StreamSubscription<List<ConnectivityResult>> _subscription;

static void observeNetwork() {
  
  _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
     final ConnectivityResult result = results.first;
    if (result == ConnectivityResult.none) {
      NetworkBloc().add(NetworkNotify());
    } else {
      NetworkBloc().add(NetworkNotify(isConnected: true));
    }
  });
}

  static void dispose() {
    _subscription.cancel();
  }
}
