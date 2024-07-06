// ignore_for_file: public_member_api_docs, must_be_immutable, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizzle_starter/src/core/services/deep%20linking/deep_linking.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/choose_login.dart';
import 'package:sizzle_starter/src/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ super.key});
   

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthenticationBloc authenticationBloc;
  bool _isBlocInitialized = false;
  late DeepLinkHandler _deepLinkHandler;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isBlocInitialized) {
      authenticationBloc = DependenciesScope.of(context).authenticationBloc;
      authenticationBloc.add(AppLoadedup());
      _isBlocInitialized = true;
    }
  }

    @override
  void initState() {
    super.initState();
    _deepLinkHandler = DeepLinkHandler(context);
    _deepLinkHandler.initDeepLinks();
  }

  @override
  void dispose() {
    _deepLinkHandler.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    authenticationBloc = DependenciesScope.of(context).authenticationBloc;
      return  Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          listener: (BuildContext context, AuthenticationState state) {
            if (state is AppAutheticated) {
              context.go('/home');
            }
            if (state is AuthenticationStart) {
              context.go('/chooseLogin');
            }
            if (state is UserLogoutState) {
              context.go('/chooseLogin');
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) => Center(child: Image.asset('assets/images/logo-removebg-preview.png'))),
        ));
  } 

}