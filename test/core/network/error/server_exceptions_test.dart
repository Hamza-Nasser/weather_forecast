import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/error/server_exceptions.dart';

void main() {
  group('ServerException', () {
    test('toString returns message when provided', () {
      const exception = ServerException('Something failed');
      expect(exception.toString(), 'Something failed');
    });

    test('toString returns default when no message', () {
      const exception = ServerException();
      expect(exception.toString(), 'An error occurred');
    });

    test('message is accessible', () {
      const exception = ServerException('Test error');
      expect(exception.message, 'Test error');
    });

    test('supports value equality via Equatable', () {
      const e1 = ServerException('Error A');
      const e2 = ServerException('Error A');
      const e3 = ServerException('Error B');

      expect(e1, equals(e2));
      expect(e1, isNot(equals(e3)));
    });
  });

  group('FetchDataException', () {
    test('has default message', () {
      const exception = FetchDataException();
      expect(exception.message, 'Error During Communication');
    });

    test('accepts custom message', () {
      const exception = FetchDataException('Custom fetch error');
      expect(exception.message, 'Custom fetch error');
    });
  });

  group('BadRequestException', () {
    test('has default message', () {
      const exception = BadRequestException();
      expect(
        exception.message,
        'Bad Request, Please Check Your Request and Try Again',
      );
    });
  });

  group('UnauthorizedException', () {
    test('has default message', () {
      const exception = UnauthorizedException();
      expect(exception.message, 'Unauthorized');
    });
  });

  group('NotFoundException', () {
    test('has default message', () {
      const exception = NotFoundException();
      expect(exception.message, 'Something went wrong');
    });
  });

  group('ConflictException', () {
    test('has default message', () {
      const exception = ConflictException();
      expect(exception.message, 'Conflict Occurred');
    });
  });

  group('InternalServerError', () {
    test('has default message', () {
      const exception = InternalServerError();
      expect(exception.message, 'Internal Server Error');
    });
  });

  group('ServiceUnavailableException', () {
    test('has default message', () {
      const exception = ServiceUnavailableException();
      expect(exception.message, 'Service Unavailable, Try Again Later');
    });
  });

  group('NoInternetConnectionException', () {
    test('has default message', () {
      const exception = NoInternetConnectionException();
      expect(exception.message, 'No Internet Connection');
    });
  });

  group('ReadFromDeviceException', () {
    test('has default message', () {
      const exception = ReadFromDeviceException();
      expect(exception.message, "Can't read from device");
    });
  });

  group('CustomException', () {
    test('message is null when not provided', () {
      const exception = CustomException();
      expect(exception.message, isNull);
    });

    test('accepts custom message', () {
      const exception = CustomException('Custom error');
      expect(exception.message, 'Custom error');
    });
  });

  group('Exception hierarchy', () {
    test('all exceptions extend ServerException', () {
      expect(const FetchDataException(), isA<ServerException>());
      expect(const BadRequestException(), isA<ServerException>());
      expect(const UnauthorizedException(), isA<ServerException>());
      expect(const NotFoundException(), isA<ServerException>());
      expect(const ConflictException(), isA<ServerException>());
      expect(const InternalServerError(), isA<ServerException>());
      expect(const ServiceUnavailableException(), isA<ServerException>());
      expect(const NoInternetConnectionException(), isA<ServerException>());
      expect(const ReadFromDeviceException(), isA<ServerException>());
      expect(const CustomException(), isA<ServerException>());
    });
  });
}
