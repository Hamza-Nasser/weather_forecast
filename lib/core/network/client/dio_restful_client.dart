import 'dart:io';

import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:weather_app/core/services/prefs/app_preferences.dart';

import '../error/server_exceptions.dart';
import 'endpoints.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/language_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'restful_client.dart';
import 'status_code.dart';

@LazySingleton(as: RestfulClient)
class DioRestfulClient implements RestfulClient {
  final Dio _client;
  static const Duration timeout = Duration(seconds: 10);

  @visibleForTesting
  DioRestfulClient.withDio(Dio client) : _client = client;

  DioRestfulClient(AppPreferences prefs) : _client = Dio() {
    _client.options.baseUrl = Endpoints.baseUrl;
    _client.options.headers = {Headers.acceptHeader: Headers.jsonContentType};
    _client.options.connectTimeout = timeout;
    _client.options.receiveTimeout = timeout;
    if (kDebugMode) {
      _client.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (log) => debugPrint(log.toString()),
        ),
      );
    }

    _client.interceptors.addAll([
      LanguageInterceptor(prefs),
      ErrorInterceptor(),
      RetryInterceptor(_client),
    ]);
  }

  @override
  Future delete(
    String path, {
    dynamic queryParameters,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _client.delete(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  @override
  Future get(
    String path, {
    dynamic queryParameters,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _client.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic queryParameters,
    dynamic body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic queryParameters,
    dynamic body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _client.post(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  @override
  Future put(
    String path, {
    dynamic queryParameters,
    dynamic body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  @override
  Future postMultipart(
    String path, {
    Map<String, String> fields = const {},
    Map<String, String> files = const {},
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData();

      for (final entry in fields.entries) {
        formData.fields.add(MapEntry(entry.key, entry.value));
      }

      for (final entry in files.entries) {
        formData.files.add(
          MapEntry(entry.key, await MultipartFile.fromFile(entry.value)),
        );
      }

      final response = await _client.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  void _errorHandler(DioException e) {
    if (e.error is SocketException) {
      throw const NoInternetConnectionException();
    }
    final response = e.response;
    String? errorMsg;
    if (response != null) {
      errorMsg = _extractErrorMsgFromResponse(response);
    }
    if (e.response?.statusCode == StatusCode.unauthorized) {
      throw UnauthorizedException(errorMsg);
    }
    if (e.response?.statusCode == StatusCode.badRequest) {
      throw BadRequestException(errorMsg);
    }
    if (e.response?.statusCode == StatusCode.notFound) {
      throw NotFoundException(errorMsg);
    }
    if (e.response?.statusCode == StatusCode.internalServerError) {
      throw ServerException(errorMsg);
    }
    throw CustomException(errorMsg);
  }

  String _extractErrorMsgFromResponse(Response response) {
    if (response.data is! Map) {
      return 'Something went wrong';
    }

    final data = response.data as Map<String, dynamic>;

    if (data['errors'] != null) {
      final errors = data['errors'];
      if (errors is Map) {
        if (errors.isNotEmpty) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          } else if (firstError != null) {
            return firstError.toString();
          }
        }
      } else if (errors is List && errors.isNotEmpty) {
        final error = errors[0];
        if (error is Map && error['msg'] != null) {
          return error['msg'].toString();
        } else if (error is Map && error['message'] != null) {
          return error['message'].toString();
        } else if (error != null) {
          return error.toString();
        }
      }
    }

    if (data['message'] != null) {
      return data['message'].toString();
    }

    if (data['error'] != null) {
      final error = data['error'];
      if (error is Map && error['message'] != null) {
        return error['message'].toString();
      }
      return error.toString();
    }

    return 'Something went wrong';
  }
}
