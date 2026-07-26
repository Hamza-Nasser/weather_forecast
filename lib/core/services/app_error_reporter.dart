import 'dart:developer' as developer;

import 'package:injectable/injectable.dart';

/// Reports unexpected failures without exposing request data or credentials.
abstract class AppErrorReporter {
  void record(Object error, StackTrace stackTrace, {required String context});
}

@LazySingleton(as: AppErrorReporter)
class DeveloperLogErrorReporter implements AppErrorReporter {
  const DeveloperLogErrorReporter();

  @override
  void record(Object error, StackTrace stackTrace, {required String context}) {
    developer.log(
      '$context (${error.runtimeType})',
      name: 'weather_app',
      stackTrace: stackTrace,
    );
  }
}
