import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Debug-only request diagnostics that intentionally omit query values,
/// headers, bodies, and response payloads.
class SafeLogInterceptor extends Interceptor {
  const SafeLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        '${options.method} ${options.path}',
        name: 'weather_app.network',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      developer.log(
        '${response.requestOptions.method} ${response.requestOptions.path} '
        '${response.statusCode ?? 0}',
        name: 'weather_app.network',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        '${err.requestOptions.method} ${err.requestOptions.path} '
        '${err.response?.statusCode ?? err.type.name}',
        name: 'weather_app.network',
      );
    }
    handler.next(err);
  }
}
