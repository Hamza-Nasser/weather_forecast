import 'package:weather_app/core/app_exceptions/app_exceptions.dart';
import 'package:weather_app/l10n/app_localizations.dart';

class ServerException extends UserFriendlyException {
  const ServerException([super.message]);

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorSomethingWentWrong;
  }

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message ?? 'An error occurred';
}

class FetchDataException extends ServerException {
  const FetchDataException([String? message])
    : super(message ?? "Error During Communication");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorFetchData;
  }
}

class BadRequestException extends ServerException {
  const BadRequestException([String? message, this.errorCode])
    : super(message ?? "Bad Request, Please Check Your Request and Try Again");

  /// Stable provider error code, when the response contains one.
  ///
  /// Feature data sources can use this code to translate a generic HTTP 400
  /// into a more specific application exception without exposing backend text.
  final int? errorCode;

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorBadRequest;
  }

  @override
  List<Object?> get props => [message, errorCode];
}

class CityNotFoundException extends ServerException {
  const CityNotFoundException() : super('City not found');

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorCityNotFound;
  }
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([String? message])
    : super(message ?? "Unauthorized");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorUnauthorized;
  }
}

class NotFoundException extends ServerException {
  const NotFoundException([String? message])
    : super(message ?? "Something went wrong");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorSomethingWentWrong;
  }
}

class ConflictException extends ServerException {
  const ConflictException([String? message])
    : super(message ?? "Conflict Occurred");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorConflict;
  }
}

class InternalServerError extends ServerException {
  const InternalServerError([String? message])
    : super(message ?? "Internal Server Error");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorInternalServer;
  }
}

class ServiceUnavailableException extends ServerException {
  const ServiceUnavailableException([String? message])
    : super(message ?? "Service Unavailable, Try Again Later");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorServiceUnavailable;
  }
}

class CustomException extends ServerException {
  const CustomException([super.message]);

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorSomethingWentWrong;
  }
}

class ConfigurationException extends ServerException {
  const ConfigurationException();

  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorMissingApiKey;
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([String? message])
    : super(message ?? "No Internet Connection");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorNoInternetConnection;
  }
}

class ReadFromDeviceException extends ServerException {
  const ReadFromDeviceException([String? message])
    : super(message ?? "Can't read from device");

  @override
  String getLocalizedMessage(AppLocalizations l10n) {
    return l10n.errorReadFromDevice;
  }
}
