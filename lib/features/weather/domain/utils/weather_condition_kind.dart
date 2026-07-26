enum WeatherConditionKind { clear, cloudy, fog, rain, snow, storm, unknown }

class WeatherConditionClassifier {
  const WeatherConditionClassifier._();

  static WeatherConditionKind fromCode(int code) {
    if (code == 1000) return WeatherConditionKind.clear;
    if ({1003, 1006, 1009}.contains(code)) {
      return WeatherConditionKind.cloudy;
    }
    if ({1030, 1135, 1147}.contains(code)) return WeatherConditionKind.fog;
    if ({1087, 1273, 1276, 1279, 1282}.contains(code)) {
      return WeatherConditionKind.storm;
    }
    if ({
      1066,
      1069,
      1072,
      1114,
      1117,
      1204,
      1207,
      1210,
      1213,
      1216,
      1219,
      1222,
      1225,
      1237,
      1249,
      1252,
      1255,
      1258,
      1261,
      1264,
    }.contains(code)) {
      return WeatherConditionKind.snow;
    }
    if ({
      1063,
      1150,
      1153,
      1168,
      1171,
      1180,
      1183,
      1186,
      1189,
      1192,
      1195,
      1198,
      1201,
      1240,
      1243,
      1246,
    }.contains(code)) {
      return WeatherConditionKind.rain;
    }
    return WeatherConditionKind.unknown;
  }

  static bool isUnsafeForOutdoorActivities(int code) {
    final kind = fromCode(code);
    return kind == WeatherConditionKind.rain ||
        kind == WeatherConditionKind.snow ||
        kind == WeatherConditionKind.storm;
  }
}
