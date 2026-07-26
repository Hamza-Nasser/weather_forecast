typedef ProgressCallback = void Function(int count, int total);

abstract class RestfulClient {
  Future<Object?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
  });

  Future<Object?> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  Future<Object?> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  Future<Object?> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  Future<Object?> delete(String path, {Map<String, dynamic>? queryParameters});

  Future<Object?> postMultipart(
    String path, {
    Map<String, String> fields = const {},
    Map<String, String> files = const {},
    ProgressCallback? onSendProgress,
  });
}
