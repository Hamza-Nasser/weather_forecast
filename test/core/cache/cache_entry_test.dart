import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/cache/cache_entry.dart';

void main() {
  group('CacheEntry', () {
    test('isExpired returns false for future expiresAt', () {
      final entry = CacheEntry(
        key: 'test',
        data: 'data',
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(entry.isExpired, isFalse);
    });

    test('isExpired returns true for past expiresAt', () {
      final entry = CacheEntry(
        key: 'test',
        data: 'data',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        expiresAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      expect(entry.isExpired, isTrue);
    });

    test('fromMap creates correct entry', () {
      final now = DateTime.now();
      final map = {
        'key': 'test_key',
        'data': '{"temp": 25}',
        'created_at': now.millisecondsSinceEpoch,
        'expires_at': now.add(const Duration(hours: 1)).millisecondsSinceEpoch,
      };

      final entry = CacheEntry.fromMap(map);

      expect(entry.key, 'test_key');
      expect(entry.data, '{"temp": 25}');
      expect(
        entry.createdAt.millisecondsSinceEpoch,
        now.millisecondsSinceEpoch,
      );
    });

    test('toMap produces map suitable for database insertion', () {
      final now = DateTime(2026, 7, 25, 12, 0);
      final expires = DateTime(2026, 7, 25, 12, 30);

      final entry = CacheEntry(
        key: 'test_key',
        data: 'test_data',
        createdAt: now,
        expiresAt: expires,
      );

      final map = entry.toMap();

      expect(map['key'], 'test_key');
      expect(map['data'], 'test_data');
      expect(map['created_at'], now.millisecondsSinceEpoch);
      expect(map['expires_at'], expires.millisecondsSinceEpoch);
    });

    test('fromMap and toMap are symmetric', () {
      final now = DateTime.now();
      final original = CacheEntry(
        key: 'round_trip',
        data: '{"test": true}',
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          now.millisecondsSinceEpoch,
        ),
        expiresAt: DateTime.fromMillisecondsSinceEpoch(
          now.add(const Duration(hours: 1)).millisecondsSinceEpoch,
        ),
      );

      final map = original.toMap();
      final restored = CacheEntry.fromMap(map);

      expect(restored.key, original.key);
      expect(restored.data, original.data);
      expect(
        restored.createdAt.millisecondsSinceEpoch,
        original.createdAt.millisecondsSinceEpoch,
      );
      expect(
        restored.expiresAt.millisecondsSinceEpoch,
        original.expiresAt.millisecondsSinceEpoch,
      );
    });
  });
}
