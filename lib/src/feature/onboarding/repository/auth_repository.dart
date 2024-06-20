// ignore_for_file: public_member_api_docs

import 'package:sizzle_starter/src/core/components/rest_client/src/rest_client_dio.dart';

class AuthRepository {
  final RestClientDio restClient;

  AuthRepository({required this.restClient});

  Future<Map<String, Object?>?> register({
    required String email,
    required String password,
  }) async {
    try {
      return await restClient.post(
        '/auth/register',
        body: {'email': email, 'password': password},
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
        '/auth/login',
        body: {'email': email, 'password': password},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Object?>?> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      return await restClient.post(
        '/auth/verify-email',
        body: {'email': email, 'otp': otp},
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
        '/auth/forgot-password',
        body: {'email': email},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Object?>?> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      return await restClient.post(
        '/auth/reset-password',
        body: {'email': email, 'newPassword': newPassword},
      );
    } catch (e) {
      rethrow;
    }
  }
}
