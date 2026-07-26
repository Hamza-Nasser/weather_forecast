class WeatherLocationTime {
  const WeatherLocationTime._();

  static int offsetMinutes({
    required String localTime,
    required int epochSeconds,
  }) {
    if (localTime.isEmpty || epochSeconds <= 0) return 0;
    final parsed = DateTime.tryParse(localTime.replaceFirst(' ', 'T'));
    if (parsed == null) return 0;
    final localWallTimeAsUtc = DateTime.utc(
      parsed.year,
      parsed.month,
      parsed.day,
      parsed.hour,
      parsed.minute,
      parsed.second,
    );
    final instant = DateTime.fromMillisecondsSinceEpoch(
      epochSeconds * 1000,
      isUtc: true,
    );
    return localWallTimeAsUtc.difference(instant).inMinutes.clamp(-840, 840);
  }

  static DateTime nowAtLocation(int offsetMinutes, {DateTime? utcNow}) =>
      (utcNow ?? DateTime.now().toUtc()).add(Duration(minutes: offsetMinutes));

  static DateTime? parseWallTime(String value) {
    final parsed = DateTime.tryParse(value.replaceFirst(' ', 'T'));
    if (parsed == null) return null;
    return DateTime.utc(
      parsed.year,
      parsed.month,
      parsed.day,
      parsed.hour,
      parsed.minute,
      parsed.second,
    );
  }
}
