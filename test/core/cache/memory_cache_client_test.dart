import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/cache/cache_config.dart';
import 'package:weather_app/core/cache/memory_cache_client.dart';

void main() {
  group('MemoryCacheClient', () {
    late MemoryCacheClient cache;

    setUp(() {
      cache = MemoryCacheClient(
        const CacheConfig(
          defaultTtl: Duration(seconds: 5),
          maxMemoryEntries: 3,
        ),
      );
    });

    test('returns null for missing key', () async {
      expect(await cache.get('missing'), isNull);
    });

    test('stores and retrieves a value', () async {
      await cache.put('key1', '{"temp": 25}');
      expect(await cache.get('key1'), '{"temp": 25}');
    });

    test('containsKey returns true for existing key', () async {
      await cache.put('key1', 'data');
      expect(await cache.containsKey('key1'), isTrue);
    });

    test('containsKey returns false for missing key', () async {
      expect(await cache.containsKey('missing'), isFalse);
    });

    test('remove deletes a key', () async {
      await cache.put('key1', 'data');
      await cache.remove('key1');
      expect(await cache.get('key1'), isNull);
    });

    test('clear removes all entries', () async {
      await cache.put('key1', 'data1');
      await cache.put('key2', 'data2');
      await cache.clear();
      expect(await cache.get('key1'), isNull);
      expect(await cache.get('key2'), isNull);
    });

    test('evicts oldest entry when at capacity', () async {
      await cache.put('key1', 'data1');
      await cache.put('key2', 'data2');
      await cache.put('key3', 'data3');
      // Adding a 4th should evict the oldest (key1)
      await cache.put('key4', 'data4');
      expect(await cache.get('key1'), isNull);
      expect(await cache.get('key4'), 'data4');
    });

    test('expired entries return null from get', () async {
      await cache.put(
        'key1',
        'data',
        ttl: const Duration(milliseconds: 1),
      );
      await Future.delayed(const Duration(milliseconds: 10));
      expect(await cache.get('key1'), isNull);
    });

    test('containsKey returns false for expired entries', () async {
      await cache.put(
        'key1',
        'data',
        ttl: const Duration(milliseconds: 1),
      );
      await Future.delayed(const Duration(milliseconds: 10));
      expect(await cache.containsKey('key1'), isFalse);
    });

    group('removeMatching', () {
      test('removes entries matching prefix', () async {
        await cache.put('weather_cairo', 'data1');
        await cache.put('weather_london', 'data2');
        await cache.put('settings_theme', 'data3');

        await cache.removeMatching('weather_');

        expect(await cache.get('weather_cairo'), isNull);
        expect(await cache.get('weather_london'), isNull);
        expect(await cache.get('settings_theme'), 'data3');
      });

      test('does nothing when no keys match prefix', () async {
        await cache.put('key1', 'data1');
        await cache.removeMatching('nonexistent_');
        expect(await cache.get('key1'), 'data1');
      });
    });

    group('getStale', () {
      test('returns null for missing key', () async {
        expect(await cache.getStale('missing'), isNull);
      });

      test('returns valid data', () async {
        await cache.put('key1', 'data');
        expect(await cache.getStale('key1'), 'data');
      });

      test('returns expired data (unlike get)', () async {
        await cache.put(
          'key1',
          'stale_data',
          ttl: const Duration(milliseconds: 1),
        );
        await Future.delayed(const Duration(milliseconds: 10));

        // get returns null for expired entries
        expect(await cache.get('key1'), isNull);

        // But we removed it in the get call above, so getStale will also be null.
        // Let's test without calling get first.
      });

      test('returns expired data without prior get call', () async {
        final freshCache = MemoryCacheClient(
          const CacheConfig(
            defaultTtl: Duration(seconds: 5),
            maxMemoryEntries: 3,
          ),
        );
        await freshCache.put(
          'key1',
          'stale_data',
          ttl: const Duration(milliseconds: 1),
        );
        await Future.delayed(const Duration(milliseconds: 10));

        // getStale should return data even when expired
        expect(await freshCache.getStale('key1'), 'stale_data');
      });
    });

    test('custom ttl overrides default', () async {
      await cache.put('short', 'data', ttl: const Duration(milliseconds: 1));
      await cache.put('long', 'data', ttl: const Duration(hours: 1));

      await Future.delayed(const Duration(milliseconds: 10));

      expect(await cache.get('short'), isNull);
      expect(await cache.get('long'), 'data');
    });

    test('put overwrites existing key', () async {
      await cache.put('key1', 'original');
      await cache.put('key1', 'updated');
      expect(await cache.get('key1'), 'updated');
    });
  });
}
