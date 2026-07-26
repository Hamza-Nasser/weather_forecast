import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/client/dio_restful_client.dart';
import 'package:weather_app/core/network/error/server_exceptions.dart';

class _StubHttpClientAdapter implements HttpClientAdapter {
  const _StubHttpClientAdapter(this.body);

  final String body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      400,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('DioRestfulClient bad-request mapping', () {
    test('retains a numeric backend error code', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
        ..httpClientAdapter = const _StubHttpClientAdapter(
          '{"error":{"code":1006,"message":"No matching location found."}}',
        );
      final client = DioRestfulClient.withDio(dio);

      await expectLater(
        client.get('/weather'),
        throwsA(
          isA<BadRequestException>().having(
            (error) => error.errorCode,
            'errorCode',
            1006,
          ),
        ),
      );
    });

    test('keeps generic bad requests generic when no code exists', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
        ..httpClientAdapter = const _StubHttpClientAdapter(
          '{"error":{"message":"Bad request"}}',
        );
      final client = DioRestfulClient.withDio(dio);

      await expectLater(
        client.get('/weather'),
        throwsA(
          isA<BadRequestException>().having(
            (error) => error.errorCode,
            'errorCode',
            isNull,
          ),
        ),
      );
    });
  });
}
