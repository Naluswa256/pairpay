// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/exception/network_exception.dart';
import 'package:sizzle_starter/src/core/helper/convertor.dart';
import 'package:sizzle_starter/src/core/services/localStorage/model/tokens.dart';
import 'package:sizzle_starter/src/core/services/localStorage/shared_pref.service.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/data/local/user_local_service.dart';
import 'package:sizzle_starter/src/feature/onboarding/repository/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final SharedPreferences sharedPreferences;
  final TokenStorageService tokenStorage;
  final UserService userService;

  AuthenticationBloc({
    required this.authRepository,
    required this.sharedPreferences,
    required this.tokenStorage,
    required this.userService,
  }) : super(AuthenticationInitial()) {
    on<AppLoadedup>(_mapAppLoadedupToState);
    on<UserLogin>(_mapUserLoginToState);
    on<UserSignUp>(_mapUserSignUpToState);
    on<UserLogOut>(_mapUserLogOutToState);
    on<VerifyEmail>(_mapVerifyEmailToState);
    on<ForgotPassword>(_mapForgotPasswordToState);
    on<ResetPassword>(_mapResetPasswordToState);
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
      await _processUserAndTokens(data, emit);
    } catch (e) {
      emit(AuthenticationFailure(message: _getErrorMessage(e)));
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
        fullNames: event.fullNames,
      );
      await _processUserAndTokens(data, emit);
    } catch (e) {
      emit(AuthenticationFailure(message: _getErrorMessage(e)));
    }
  }

  Future<void> _processUserAndTokens(
    Map<String, Object?>? data,
    Emitter<AuthenticationState> emit,
  ) async {
    final userMap = data!['user'];
    final user = User.fromJson(convertMap(userMap as Map<String, Object?>?));
    await userService.saveUser(user);
    final tokens = _extractTokensFromData(data);
    await tokenStorage.setAccessToken(tokens.accessToken);
    await tokenStorage.setRefreshToken(tokens.refreshToken);

    emit(AppAutheticated());
  }

  void _mapUserLogOutToState(
    UserLogOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await tokenStorage.removeAccessToken();
    await tokenStorage.removeRefreshToken();
    emit(UserLogoutState());
  }

  void _mapVerifyEmailToState(
    VerifyEmail event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await authRepository.verifyEmail(
        otp: event.Otp,
      );
      emit(EmailVerified());
    } catch (e) {
      emit(AuthenticationFailure(message: _getErrorMessage(e)));
    }
  }

  void _mapForgotPasswordToState(
    ForgotPassword event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await authRepository.forgotPassword(email: event.email);
      emit(ForgotPasswordSent());
    } catch (e) {
      emit(AuthenticationFailure(message: _getErrorMessage(e)));
    }
  }

  void _mapResetPasswordToState(
    ResetPassword event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await authRepository.resetPassword(
        token: event.token,
        newPassword: event.newPassword,
      );
      emit(PasswordResetSuccessful());
    } catch (e) {
      emit(AuthenticationFailure(message: _getErrorMessage(e)));
    }
  }

  Token _extractTokensFromData(Map<String, Object?>? json) {
    final Object? tokensObject = json!['tokens'];
    if (tokensObject is Map<String, Object?>) {
      final Map<String, Object?> tokens = tokensObject;

      final Object? accessObject = tokens['access'];
      final Object? refreshObject = tokens['refresh'];

      if (accessObject is Map<String, Object?> && refreshObject is Map<String, Object?>) {
        final Map<String, Object?> access = accessObject;
        final Map<String, Object?> refresh = refreshObject;

        final String accessToken = access['token'] as String? ?? '';
        final String refreshToken = refresh['token'] as String? ?? '';

        return Token(accessToken, refreshToken);
      } else {
        throw Exception('Invalid tokens structure in JSON');
      }
    } else {
      throw Exception('Tokens not found or invalid type in JSON');
    }
  }

  String _getErrorMessage(Object e) {
    if (e is CustomBackendException) {
      return e.message;
    } else if (e is RestClientException) {
      return e.message;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
