
// ignore_for_file: public_member_api_docs, inference_failure_on_untyped_parameter

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/core/network_health_check/bloc/network_bloc_events.dart';
import 'package:sizzle_starter/src/core/network_health_check/bloc/network_bloc_states.dart';
import 'package:sizzle_starter/src/core/network_health_check/networkHelper.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {

  factory NetworkBloc() => _instance;
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}