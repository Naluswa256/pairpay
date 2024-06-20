import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:sizzle_starter/src/core/components/rest_client/rest_client.dart';

/// {@macro rest_client}
@immutable
abstract base class RestClientBase implements RestClient {
  /// {@macro rest_client}
  RestClientBase({required String baseUrl}) : baseUri = Uri.parse(baseUrl);

  /// The base URL for the client
  final Uri baseUri;

  /// Builds [Uri] from [path], [queryParams] and [baseUri]
  @protected
  @visibleForTesting
  Uri buildUri({required String path, Map<String, Object?>? queryParams}) {
    final finalPath = p.canonicalize(p.join(baseUri.path, path));
    return baseUri.replace(
      path: finalPath,
      queryParameters: {
        ...baseUri.queryParameters,
        if (queryParams != null) ...queryParams,
      },
    );
  }

  /// Decodes [body] from JSON
  @protected
  @visibleForTesting
  FutureOr<Map<String, Object?>?> decodeResponse(
    Object? body, {
    int? statusCode,
  }) async {
    if (body == null) return null;
    try {
      Map<String, Object?> result;
      if (body is String) {
        if (body.length > 1000) {
          result = await Isolate.run(
            () => json.decode(body) as Map<String, Object?>,
          );
        } else {
          result = json.decode(body) as Map<String, Object?>;
        }
      } else if (body is Map<String, Object?>) {
        result = body;
      } else {
        throw WrongResponseTypeException(
          message: 'Unexpected response body type: ${body.runtimeType}',
          statusCode: statusCode,
        );
      }
      if (result.containsKey('code') && result['code'] is int) {
      final errorMessage = result['message'] as String?;
      throw CustomBackendException(
        message: '$errorMessage',
        statusCode: statusCode, error: const {},
      );
    }

      if (result case {'data': final Map<String, Object?> data}) {
        return data;
      }

      return null;
    } on RestClientException {
      rethrow;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ClientException(
          message: 'Error occurred during decoding',
          statusCode: statusCode,
          cause: e,
        ),
        stackTrace,
      );
    }
  }
}
