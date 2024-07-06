// ignore_for_file: avoid_dynamic_calls, public_member_api_docs

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/auth/model/token.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/auth/token_storage.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/exception/network_exception.dart';
import 'package:sizzle_starter/src/core/constant/api_constants.dart';

/// The client that refreshes the Auth token using the refresh token.
///
/// This client is used by the [AuthInterceptor] to refresh the Auth token.
abstract interface class RefreshClient<T> {
  /// Refresh the Auth token.
  ///
  /// This method is called by the [AuthInterceptor]
  /// when the request fails with a 401.
  Future<T?> refreshToken(T token);
}

class DioRefreshTokenClient implements RefreshClient<TokenModel> {
  final InMemoryTokenStorage tokenStorage;
  final Dio dio;

  DioRefreshTokenClient({required this.tokenStorage, required this.dio});

  @override
  Future<TokenModel?> refreshToken(TokenModel tokenPair) async {
    try {
      // Create a new Dio instance to avoid interceptor conflicts
      final dioRefresh = Dio(dio.options);
      dioRefresh.interceptors.add(PrettyDioLogger());

      // Get refresh token from local storage
      final currentTokenPair = await tokenStorage.loadTokenPair();
      final currentRefreshToken = currentTokenPair?.refreshToken;

      // Ensure the provided token matches the stored one (optional)
      if (currentRefreshToken != tokenPair.refreshToken) {
        throw Exception("Provided refresh token doesn't match stored token");
      }

      // Prepare the request data
      final data = {kRefreshToken: tokenPair.refreshToken};

      // Make the POST request to the token endpoint
      final response = await dioRefresh.post<dynamic>(
        APIEndpoints.refreshToken,
        data: data,
        options: Options(
          headers: <String, dynamic>{kAccept: kApplicationJson},
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response.data['access'][kToken] as String?;
        final newRefreshToken = response.data['refresh'][kToken] as String?;
        if (newAccessToken != null && newRefreshToken != null) {
          final newTokenPair = TokenModel(newAccessToken, newRefreshToken);

          await tokenStorage.saveTokenPair(newTokenPair);

          return newTokenPair;
        }
      } else if (response.statusCode == 401) {
        // Refresh token is invalid (potentially revoked by the server)
        return null;
      } else {
        throw ClientException(
          message: 'Unexpected response status code: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        Error.throwWithStackTrace(
          ConnectionException(
            message: 'ConnectionException',
            statusCode: e.response?.statusCode,
            cause: e,
          ),
          e.stackTrace,
        );
      }
      Error.throwWithStackTrace(
        ClientException(
          message: e.toString(),
          statusCode: e.response?.statusCode,
          cause: e,
        ),
        e.stackTrace,
      );
    } catch (e, stack) {
      Error.throwWithStackTrace(
        ClientException(message: e.toString(), cause: e),
        stack,
      );
    }
    return null;
  }
}
