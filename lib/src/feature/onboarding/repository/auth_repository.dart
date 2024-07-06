// ignore_for_file: public_member_api_docs

import 'package:sizzle_starter/src/core/components/rest_client/src/rest_client_dio.dart';

class AuthRepository {
  final RestClientDio restClient;

  AuthRepository({required this.restClient});

  Future<Map<String, Object?>?> register({
    required String email,
    required String password,
    required String fullNames
  }) async {
    try {
      return await restClient.post(
        'v1/auth/register',
        body: {'email': email, 'password': password,'fullNames':fullNames},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Object?>?> login({
    required String email,
    required String password,
  }) async {
    try {
      return await restClient.post(
        'v1/auth/login',
        body: {'email': email, 'password': password},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Object?>?> verifyEmail({
    required String otp,
  }) async {
    try {
      return await restClient.post(
        'v1/auth/verify-email',
        body: {'Otp': otp},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Object?>?> forgotPassword({
    required String email,
  }) async {
    try {
      return await restClient.post(
        'v1/auth/forgot-password',
        body: {'email': email},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Object?>?> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      return await restClient.post(
        'v1/auth/reset-password',
        body: {'newPassword': newPassword},
        queryParams: {'token': token},
      );
    } catch (e) {
      rethrow;
    }
  }
}
