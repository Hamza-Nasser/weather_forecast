import 'package:equatable/equatable.dart';
import 'package:weather_app/l10n/app_localizations.dart';

/// Base exception class for all app-level exceptions.
///
/// Any exception that occurs in the app should extend this class.
/// The [message] is intended to be user-facing (safe to display in UI).
abstract class UserFriendlyException extends Equatable implements Exception {
  final String? message;

  const UserFriendlyException([this.message]);

  /// Returns the localized representation of this exception using type-safe localizations.
  String getLocalizedMessage(AppLocalizations l10n);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message ?? 'An error occurred';
}
