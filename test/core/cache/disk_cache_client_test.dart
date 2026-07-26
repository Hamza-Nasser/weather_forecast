import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/core/cache/cache_config.dart';
import 'package:weather_app/core/cache/disk_cache_client.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  group('DiskCacheClient', () {
    late MockDatabase database;
    late DiskCacheClient cache;

    setUp(() {
      database = MockDatabase();
      cache = DiskCacheClient(const CacheConfig())
        ..setDatabaseForTesting(database);
    });

    test('evicts expired entries after a successful write', () async {
      when(
        () => database.insert(
          'cache_entries',
          any(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).thenAnswer((_) async => 1);
      when(
        () => database.delete(
          'cache_entries',
          where: 'expires_at <= ?',
          whereArgs: any(named: 'whereArgs'),
        ),
      ).thenAnswer((_) async => 2);

      await cache.put('weather_cairo', '{"temp": 30}');

      verify(
        () => database.delete(
          'cache_entries',
          where: 'expires_at <= ?',
          whereArgs: any(named: 'whereArgs'),
        ),
      ).called(1);
    });
  });
}
