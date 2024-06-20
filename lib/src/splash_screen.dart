// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({required this.authenticationBloc, Key? key}) : super(key: key);
   AuthenticationBloc authenticationBloc;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: widget.authenticationBloc,
          listener: (BuildContext context, AuthenticationState state) {
            if (state is AppAutheticated) {
            }
            if (state is AuthenticationStart) {
            }
            if (state is UserLogoutState) {
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: widget.authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) => Center(child: Image.asset('assets/images/logo-removebg-preview.png'))),
        ));

  @override
  void initState() {
    widget.authenticationBloc.add(AppLoadedup());
    super.initState();
  }
}