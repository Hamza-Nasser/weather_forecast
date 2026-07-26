/// Utility for calculating sun progress from sunrise/sunset times.
///
/// Used by the sun arc painter and weather cards to show the sun's
/// current position between sunrise and sunset.
class SunProgressCalculator {
  const SunProgressCalculator._();

  /// Calculates the sun's progress as a value between 0.0 and 1.0.
  ///
  /// Returns 0.0 before sunrise, 1.0 after sunset, and a proportional
  /// value in between. Returns 0.5 if times cannot be parsed.
  ///
  /// [sunrise] and [sunset] are expected in "HH:MM AM/PM" format
  /// (e.g., "05:30 AM", "07:15 PM").
  static double calculate(String sunrise, String sunset, {DateTime? now}) {
    if (sunrise.isEmpty || sunset.isEmpty) return 0.5;

    final sunriseMinutes = _parseTimeToMinutes(sunrise);
    final sunsetMinutes = _parseTimeToMinutes(sunset);

    if (sunriseMinutes == null || sunsetMinutes == null) return 0.5;
    if (sunsetMinutes <= sunriseMinutes) return 0.5;

    final current = now ?? DateTime.now();
    final currentMinutes = current.hour * 60 + current.minute;

    if (currentMinutes <= sunriseMinutes) return 0.0;
    if (currentMinutes >= sunsetMinutes) return 1.0;

    return (currentMinutes - sunriseMinutes) /
        (sunsetMinutes - sunriseMinutes);
  }

  /// Parses a time string like "05:30 AM" or "07:15 PM" into total minutes
  /// since midnight.
  static int? _parseTimeToMinutes(String time) {
    final cleaned = time.trim().toUpperCase();

    // Try 12-hour format: "05:30 AM", "07:15 PM"
    final amPmMatch = RegExp(r'^(\d{1,2}):(\d{2})\s*(AM|PM)$').firstMatch(cleaned);
    if (amPmMatch != null) {
      var hours = int.parse(amPmMatch.group(1)!);
      final minutes = int.parse(amPmMatch.group(2)!);
      final period = amPmMatch.group(3)!;

      if (period == 'AM' && hours == 12) hours = 0;
      if (period == 'PM' && hours != 12) hours += 12;

      return hours * 60 + minutes;
    }

    // Try 24-hour format: "17:30"
    final h24Match = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(cleaned);
    if (h24Match != null) {
      final hours = int.parse(h24Match.group(1)!);
      final minutes = int.parse(h24Match.group(2)!);
      return hours * 60 + minutes;
    }

    return null;
  }
}
