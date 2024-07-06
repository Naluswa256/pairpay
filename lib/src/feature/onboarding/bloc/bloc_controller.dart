// ignore_for_file: join_return_with_assignment, public_member_api_docs

import 'package:sizzle_starter/src/core/components/rest_client/src/rest_client_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizzle_starter/src/core/services/localStorage/shared_pref.service.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/data/local/user_local_service.dart';
import 'package:sizzle_starter/src/feature/onboarding/repository/auth_repository.dart';

class AuthenticationBlocController {
  
  factory AuthenticationBlocController({
    required RestClientDio restClient,
    required SharedPreferences sharedPreferences,
    required TokenStorageService tokenStorage,
    required UserService userService
  }) {
    _instance = AuthenticationBlocController._(
      AuthenticationBloc(
        authRepository: AuthRepository(restClient: restClient),
        sharedPreferences: sharedPreferences,
        tokenStorage: tokenStorage,
        userService: userService
      ),
    );
    return _instance;
  }
  AuthenticationBlocController._(this.authenticationBloc);

  static late final AuthenticationBlocController _instance;

  final AuthenticationBloc authenticationBloc;
}
