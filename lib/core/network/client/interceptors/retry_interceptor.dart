import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int retryDelayInMillis;

  RetryInterceptor(
    this.dio, {
    this.maxRetries = 3,
    this.retryDelayInMillis = 1000,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra["isRetry"] == null) {
      options.extra["retries"] = 0;
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    err.requestOptions.extra["retries"] ??= 0;
    if (_shouldRetry(err) &&
        err.requestOptions.extra["retries"] < maxRetries) {
      err.requestOptions.extra["retries"] += 1;

      // Add "isRetry" flag to differentiate retry from original request
      err.requestOptions.extra["isRetry"] = true;

      // Delay before retrying (exponential backoff)
      await Future.delayed(
        Duration(
          milliseconds:
              retryDelayInMillis * err.requestOptions.extra["retries"] as int,
        ),
      );

      try {
        final response = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: err.requestOptions.extra,
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException error) {
    return (error.type == DioExceptionType.unknown &&
            error.error is SocketException) ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout;
  }
}
