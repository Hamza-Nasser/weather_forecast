class WeatherWindScale {
  const WeatherWindScale._();

  static int beaufort(double speedKph) {
    if (speedKph <= 1) return 0;
    if (speedKph <= 5) return 1;
    if (speedKph <= 11) return 2;
    if (speedKph <= 19) return 3;
    if (speedKph <= 28) return 4;
    if (speedKph <= 38) return 5;
    if (speedKph <= 49) return 6;
    if (speedKph <= 61) return 7;
    if (speedKph <= 74) return 8;
    if (speedKph <= 88) return 9;
    if (speedKph <= 102) return 10;
    if (speedKph <= 117) return 11;
    return 12;
  }
}
