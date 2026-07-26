import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/cache/cache_client_impl.dart';
import 'package:weather_app/core/cache/disk_cache_client.dart';
import 'package:weather_app/core/cache/memory_cache_client.dart';

class MockMemoryCacheClient extends Mock implements MemoryCacheClient {}

class MockDiskCacheClient extends Mock implements DiskCacheClient {}

void main() {
  group('CacheClientImpl', () {
    late MockMemoryCacheClient mockMemory;
    late MockDiskCacheClient mockDisk;
    late CacheClient sut;

    setUp(() {
      mockMemory = MockMemoryCacheClient();
      mockDisk = MockDiskCacheClient();
      sut = CacheClientImpl(mockMemory, mockDisk);
    });

    group('get', () {
      test('returns memory-cached value when available', () async {
        when(() => mockMemory.get('key')).thenAnswer((_) async => 'from_memory');

        final result = await sut.get('key');

        expect(result, 'from_memory');
        verifyNever(() => mockDisk.get(any()));
      });

      test('falls back to disk when memory misses', () async {
        when(() => mockMemory.get('key')).thenAnswer((_) async => null);
        when(() => mockDisk.get('key')).thenAnswer((_) async => 'from_disk');
        when(() => mockMemory.put('key', 'from_disk'))
            .thenAnswer((_) async {});

        final result = await sut.get('key');

        expect(result, 'from_disk');
        verify(() => mockMemory.put('key', 'from_disk')).called(1);
      });

      test('returns null when both memory and disk miss', () async {
        when(() => mockMemory.get('key')).thenAnswer((_) async => null);
        when(() => mockDisk.get('key')).thenAnswer((_) async => null);

        final result = await sut.get('key');

        expect(result, isNull);
      });
    });

    group('getStale', () {
      test('returns memory stale value when available', () async {
        when(() => mockMemory.getStale('key'))
            .thenAnswer((_) async => 'stale_memory');

        final result = await sut.getStale('key');

        expect(result, 'stale_memory');
        verifyNever(() => mockDisk.getStale(any()));
      });

      test('falls back to disk stale when memory has nothing', () async {
        when(() => mockMemory.getStale('key')).thenAnswer((_) async => null);
        when(() => mockDisk.getStale('key'))
            .thenAnswer((_) async => 'stale_disk');

        final result = await sut.getStale('key');

        expect(result, 'stale_disk');
      });

      test('returns null when neither has stale data', () async {
        when(() => mockMemory.getStale('key')).thenAnswer((_) async => null);
        when(() => mockDisk.getStale('key')).thenAnswer((_) async => null);

        final result = await sut.getStale('key');

        expect(result, isNull);
      });
    });

    group('put', () {
      test('writes to both memory and disk', () async {
        when(() => mockMemory.put('key', 'value'))
            .thenAnswer((_) async {});
        when(() => mockDisk.put('key', 'value')).thenAnswer((_) async {});

        await sut.put('key', 'value');

        verify(() => mockMemory.put('key', 'value')).called(1);
        verify(() => mockDisk.put('key', 'value')).called(1);
      });

      test('passes custom ttl to both caches', () async {
        const ttl = Duration(minutes: 5);
        when(() => mockMemory.put('key', 'value', ttl: ttl))
            .thenAnswer((_) async {});
        when(() => mockDisk.put('key', 'value', ttl: ttl))
            .thenAnswer((_) async {});

        await sut.put('key', 'value', ttl: ttl);

        verify(() => mockMemory.put('key', 'value', ttl: ttl)).called(1);
        verify(() => mockDisk.put('key', 'value', ttl: ttl)).called(1);
      });
    });

    group('remove', () {
      test('removes from both memory and disk', () async {
        when(() => mockMemory.remove('key')).thenAnswer((_) async {});
        when(() => mockDisk.remove('key')).thenAnswer((_) async {});

        await sut.remove('key');

        verify(() => mockMemory.remove('key')).called(1);
        verify(() => mockDisk.remove('key')).called(1);
      });
    });

    group('clear', () {
      test('clears both memory and disk', () async {
        when(() => mockMemory.clear()).thenAnswer((_) async {});
        when(() => mockDisk.clear()).thenAnswer((_) async {});

        await sut.clear();

        verify(() => mockMemory.clear()).called(1);
        verify(() => mockDisk.clear()).called(1);
      });
    });

    group('containsKey', () {
      test('returns true if memory contains key', () async {
        when(() => mockMemory.containsKey('key'))
            .thenAnswer((_) async => true);

        expect(await sut.containsKey('key'), isTrue);
        verifyNever(() => mockDisk.containsKey(any()));
      });

      test('falls back to disk when memory misses', () async {
        when(() => mockMemory.containsKey('key'))
            .thenAnswer((_) async => false);
        when(() => mockDisk.containsKey('key')).thenAnswer((_) async => true);

        expect(await sut.containsKey('key'), isTrue);
      });

      test('returns false when neither contains key', () async {
        when(() => mockMemory.containsKey('key'))
            .thenAnswer((_) async => false);
        when(() => mockDisk.containsKey('key'))
            .thenAnswer((_) async => false);

        expect(await sut.containsKey('key'), isFalse);
      });
    });

    group('removeMatching', () {
      test('delegates to both memory and disk', () async {
        when(() => mockMemory.removeMatching('prefix_'))
            .thenAnswer((_) async {});
        when(() => mockDisk.removeMatching('prefix_'))
            .thenAnswer((_) async {});

        await sut.removeMatching('prefix_');

        verify(() => mockMemory.removeMatching('prefix_')).called(1);
        verify(() => mockDisk.removeMatching('prefix_')).called(1);
      });
    });
  });
}
