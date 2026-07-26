import 'dart:io';

import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/network/client/endpoints.dart';
import 'package:weather_app/core/network/client/interceptors/language_interceptor.dart';
import 'package:weather_app/core/network/client/interceptors/retry_interceptor.dart';
import 'package:weather_app/core/network/client/interceptors/safe_log_interceptor.dart';
import 'package:weather_app/core/network/client/restful_client.dart';
import 'package:weather_app/core/network/client/status_code.dart';
import 'package:weather_app/core/network/error/server_exceptions.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';

@LazySingleton(as: RestfulClient)
class DioRestfulClient implements RestfulClient {
  DioRestfulClient(AppPreferences prefs) : _client = Dio() {
    _client.options
      ..baseUrl = Endpoints.baseUrl
      ..headers = {Headers.acceptHeader: Headers.jsonContentType}
      ..connectTimeout = timeout
      ..receiveTimeout = timeout;
    _client.interceptors.addAll([
      LanguageInterceptor(prefs),
      const SafeLogInterceptor(),
      RetryInterceptor(_client),
    ]);
  }

  @visibleForTesting
  DioRestfulClient.withDio(Dio client) : _client = client;

  static const Duration timeout = Duration(seconds: 10);
  final Dio _client;

  @override
  Future<Object?> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => _request(
    () => _client.delete<Object?>(path, queryParameters: queryParameters),
  );

  @override
  Future<Object?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
  }) => _request(
    () => _client.get<Object?>(
      path,
      queryParameters: queryParameters,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  @override
  Future<Object?> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) => _request(
    () => _client.patch<Object?>(
      path,
      queryParameters: queryParameters,
      data: body,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ),
  );

  @override
  Future<Object?> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) => _request(
    () => _client.post<Object?>(
      path,
      queryParameters: queryParameters,
      data: body,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ),
  );

  @override
  Future<Object?> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) => _request(
    () => _client.put<Object?>(
      path,
      queryParameters: queryParameters,
      data: body,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    ),
  );

  @override
  Future<Object?> postMultipart(
    String path, {
    Map<String, String> fields = const {},
    Map<String, String> files = const {},
    ProgressCallback? onSendProgress,
  }) async {
    final formData = FormData();
    formData.fields.addAll(fields.entries);
    for (final entry in files.entries) {
      formData.files.add(
        MapEntry(entry.key, await MultipartFile.fromFile(entry.value)),
      );
    }
    return _request(
      () => _client.post<Object?>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      ),
    );
  }

  Future<Object?> _request(Future<Response<Object?>> Function() send) async {
    try {
      return (await send()).data;
    } on DioException catch (error) {
      _throwMapped(error);
    }
  }

  Never _throwMapped(DioException error) {
    if (error.error is SocketException ||
        error.type == DioExceptionType.connectionError) {
      throw const NoInternetConnectionException();
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      throw const FetchDataException();
    }

    switch (error.response?.statusCode) {
      case StatusCode.badRequest:
        throw BadRequestException(
          null,
          _extractErrorCode(error.response?.data),
        );
      case StatusCode.unauthorized:
      case StatusCode.forbidden:
        throw const UnauthorizedException();
      case StatusCode.notFound:
        throw const NotFoundException();
      case StatusCode.conflict:
        throw const ConflictException();
      case StatusCode.tooManyRequests:
      case StatusCode.serviceUnavailable:
        throw const ServiceUnavailableException();
      case StatusCode.internalServerError:
      case StatusCode.badGateway:
      case StatusCode.gatewayTimeout:
        throw const InternalServerError();
      default:
        throw const CustomException();
    }
  }

  int? _extractErrorCode(Object? responseData) {
    if (responseData is! Map) return null;
    final error = responseData['error'];
    if (error is! Map) return null;
    final code = error['code'];
    if (code is int) return code;
    if (code is num) return code.toInt();
    if (code is String) return int.tryParse(code);
    return null;
  }
}
