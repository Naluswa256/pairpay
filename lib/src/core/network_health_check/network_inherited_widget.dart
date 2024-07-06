// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/core/network_health_check/bloc/network_bloc.dart';
import 'package:sizzle_starter/src/core/network_health_check/bloc/network_bloc_events.dart';
import 'package:sizzle_starter/src/core/network_health_check/bloc/network_bloc_states.dart';

class NetworkAwareWidget extends StatefulWidget {
  final Widget child;

  NetworkAwareWidget({required this.child});

  @override
  _NetworkAwareWidgetState createState() => _NetworkAwareWidgetState();
}

class _NetworkAwareWidgetState extends State<NetworkAwareWidget> {
  late NetworkBloc _networkBloc;

  @override
  void initState() {
    super.initState();
    _networkBloc = NetworkBloc()..add(NetworkObserve());
  }

  void _showConnectivityToast(bool isConnected) {
    String message = isConnected ? 'Back online' : 'No internet connection';
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    _networkBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => _networkBloc,
      child: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is NetworkSuccess) {
            _showConnectivityToast(true);
          } else if (state is NetworkFailure) {
            _showConnectivityToast(false);
          }
        },
        child: widget.child,
      ),
    );
}
