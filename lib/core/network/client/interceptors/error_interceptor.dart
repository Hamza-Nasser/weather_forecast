import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/network/client/status_code.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == StatusCode.unauthorized) {
      debugPrint('Unauthorized error, status code: 401');
    } else if (err.response?.statusCode == StatusCode.internalServerError) {
      debugPrint('Server error, status code: 500');
    }
    return handler.next(err);
  }
}
