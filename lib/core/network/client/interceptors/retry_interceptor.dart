import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor(
    this.dio, {
    this.maxRetries = 3,
    this.retryDelay = const Duration(milliseconds: 500),
  });

  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = options.extra['retryAttempt'] as int? ?? 0;
    if (!_isIdempotent(options.method) ||
        !_isTransient(err) ||
        attempt >= maxRetries) {
      handler.next(err);
      return;
    }

    options.extra['retryAttempt'] = attempt + 1;
    await Future<void>.delayed(retryDelay * (1 << attempt));

    try {
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _isIdempotent(String method) =>
      method.toUpperCase() == 'GET' || method.toUpperCase() == 'HEAD';

  bool _isTransient(DioException error) =>
      (error.type == DioExceptionType.unknown &&
          error.error is SocketException) ||
      error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.response?.statusCode == 429 ||
      (error.response?.statusCode ?? 0) >= 500;
}
