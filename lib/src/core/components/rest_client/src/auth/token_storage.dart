// ignore_for_file: public_member_api_docs, avoid_void_async

import 'dart:async';

import 'package:sizzle_starter/src/core/components/rest_client/src/auth/auth_interceptor.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/auth/model/token.dart';
import 'package:sizzle_starter/src/core/services/localStorage/shared_pref.service.dart';

/// The interface for token storage.
///
/// This interface is used by the [AuthInterceptor]
/// to store and retrieve the Auth token pair.
abstract interface class TokenStorage<T> {
  /// Load the Auth token pair.
  Future<T?> loadTokenPair();

  /// Save the Auth token pair.
  Future<void> saveTokenPair(T tokenPair);

  /// Clear the Auth token pair.
  ///
  /// This is used to clear the token pair when the request fails with a 401.
  Future<void> clearTokenPair();

  /// A stream of token pairs.
  Stream<T?> getTokenPairStream();

  /// Close the token storage.
  Future<void> close();
}




class InMemoryTokenStorage implements TokenStorage<TokenModel> {
  final TokenStorageService _storageService;
  final _tokenPairController = StreamController<TokenModel?>.broadcast();

  InMemoryTokenStorage(this._storageService) {
    _initialize();
  }

  Future<void> _initialize() async {
    final tokenPair = await loadTokenPair();
    _tokenPairController.add(tokenPair);

    _storageService.addAccessTokenListener(_notifyTokenPairChange);
    _storageService.addRefreshTokenListener(_notifyTokenPairChange);
  }

  void _notifyTokenPairChange() async {
    final tokenPair = await loadTokenPair();
    _tokenPairController.add(tokenPair);
  }

  @override
  Future<TokenModel?> loadTokenPair() async {
    final String? accessToken = _storageService.accessTokenEntry.read();
    final String? refreshToken = _storageService.refreshTokenEntry.read();
    if (accessToken != null && refreshToken != null) {
      return TokenModel(accessToken, refreshToken);
    }
    return null;
  }

  @override
  Future<void> saveTokenPair(TokenModel tokenPair) async {
    await _storageService.setAccessToken(tokenPair.accessToken);
    await _storageService.setRefreshToken(tokenPair.refreshToken);
  }

  @override
  Future<void> clearTokenPair() async {
    await _storageService.removeAccessToken();
    await _storageService.removeRefreshToken();
  }

  @override
  Stream<TokenModel?> getTokenPairStream() => _tokenPairController.stream;

  @override
  Future<void> close() async {
    await _tokenPairController.close();
    _storageService.removeAccessTokenListener(_notifyTokenPairChange);
    _storageService.removeRefreshTokenListener(_notifyTokenPairChange);
  }
}