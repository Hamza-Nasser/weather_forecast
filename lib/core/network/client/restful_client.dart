/// {@template dio.options.ProgressCallback}
/// The type of a progress listening callback when sending or receiving data.
///
/// [count] is the length of the bytes have been sent/received.
///
/// [total] is the content length of the response/request body.
/// 1. When sending data, [total] is the request body length.
/// 2. When receiving data, [total] will be -1 if the size of the response body,
///    typically with no `content-length` header.
/// {@endtemplate}
typedef ProgressCallback = void Function(int count, int total);

abstract class RestfulClient {
  Future get(
    String path, {
    dynamic queryParameters,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  Future post(
    String path, {
    dynamic queryParameters,
    dynamic body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  Future put(
    String path, {
    dynamic queryParameters,
    dynamic body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  Future patch(
    String path, {
    dynamic queryParameters,
    dynamic body,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  Future delete(
    String path, {
    dynamic queryParameters,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  /// Sends a multipart POST request with both text fields and file attachments.
  ///
  /// [fields] contains key-value pairs of text form fields.
  /// [files] maps field names to file paths on disk.
  Future postMultipart(
    String path, {
    Map<String, String> fields = const {},
    Map<String, String> files = const {},
    ProgressCallback? onSendProgress,
  });
}
