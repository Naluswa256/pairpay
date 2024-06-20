// ignore_for_file: avoid_dynamic_calls

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizzle_starter/src/core/services/localStorage/model/tokens.dart';
import 'package:sizzle_starter/src/core/services/localStorage/shared_pref.service.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/repository/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final SharedPreferences sharedPreferences;
  final TokenStorageService tokenStorage;

  AuthenticationBloc({
    required this.authRepository,
    required this.sharedPreferences,
    required this.tokenStorage,
  }) : super(AuthenticationInitial()) {
    on<AppLoadedup>(_mapAppLoadedupToState);
    on<UserLogin>(_mapUserLoginToState);
    on<UserSignUp>(_mapUserSignUpToState);
    on<UserLogOut>(_mapUserLogOutToState);
  }

  void _mapAppLoadedupToState(
    AppLoadedup event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      final tokens = tokenStorage.accessTokenEntry.read();
      if (tokens != null) {
        emit(AppAutheticated());
      } else {
        emit(AuthenticationStart());
      }
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  void _mapUserLoginToState(
    UserLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      final data = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      final tokens = _extractTokensFromData(data);
      if (tokens != null) {
        await tokenStorage.setAccessToken(tokens.accessToken);
        await tokenStorage.setRefreshToken(tokens.refreshToken);
        emit(AppAutheticated());
      } else {
        emit(AuthenticationNotAuthenticated());
      }
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  void _mapUserSignUpToState(
    UserSignUp event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      final data = await authRepository.register(
        email: event.email,
        password: event.password,
      );
      final tokens = _extractTokensFromData(data);
      if (tokens != null) {
        await tokenStorage.setAccessToken(tokens.accessToken);
        await tokenStorage.setRefreshToken(tokens.refreshToken);
        emit(AppAutheticated());
      } else {
        emit(AuthenticationNotAuthenticated());
      }
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  void _mapUserLogOutToState(
    UserLogOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await tokenStorage.removeAccessToken();
    await tokenStorage.removeRefreshToken();
    emit(UserLogoutState());
  }

  // Helper method to extract tokens from data
  Token? _extractTokensFromData(Map<String, Object?>? data) {
    if (data != null && data['tokens'] is Map<String, dynamic>) {
      final Map<String, dynamic> tokensData =
          data['tokens']! as Map<String, dynamic>;

      final String? accessToken =
          tokensData['access']?['token'] as String?;
      final String? refreshToken =
          tokensData['refresh']?['token'] as String?;

      if (accessToken != null && refreshToken != null) {
        return Token(accessToken, refreshToken);
      }
    }
    return null;
  }
}
