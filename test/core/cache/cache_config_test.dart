import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/cache/cache_config.dart';

void main() {
  group('CacheConfig', () {
    test('default constructor has 15-minute TTL', () {
      const config = CacheConfig();

      expect(config.defaultTtl, const Duration(minutes: 15));
      expect(config.maxMemoryEntries, 100);
      expect(config.diskDatabaseName, 'weather_cache.db');
    });

    test('defaultConfig named constructor matches default values', () {
      const config = CacheConfig.defaultConfig();

      expect(config.defaultTtl, const Duration(minutes: 15));
      expect(config.maxMemoryEntries, 100);
      expect(config.diskDatabaseName, 'weather_cache.db');
    });

    test('accepts custom values', () {
      const config = CacheConfig(
        defaultTtl: Duration(hours: 1),
        maxMemoryEntries: 50,
        diskDatabaseName: 'custom.db',
      );

      expect(config.defaultTtl, const Duration(hours: 1));
      expect(config.maxMemoryEntries, 50);
      expect(config.diskDatabaseName, 'custom.db');
    });
  });
}
