import 'package:injectable/injectable.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/cache/disk_cache_client.dart';
import 'package:weather_app/core/cache/memory_cache_client.dart';

/// Composite [CacheClient] that coordinates caching across Memory and Disk.
///
/// Ensures memory is checked first, then disk, falling back to null.
@LazySingleton(as: CacheClient)
class CacheClientImpl implements CacheClient {
  final MemoryCacheClient _memoryCache;
  final DiskCacheClient _diskCache;

  const CacheClientImpl(this._memoryCache, this._diskCache);

  @override
  Future<String?> get(String key) async {
    // 1. Try Memory
    final memoryValue = await _memoryCache.get(key);
    if (memoryValue != null) {
      return memoryValue;
    }

    // 2. Try Disk
    final diskValue = await _diskCache.get(key);
    if (diskValue != null) {
      // Warm up memory cache
      await _memoryCache.put(key, diskValue);
      return diskValue;
    }

    return null;
  }

  @override
  Future<String?> getStale(String key) async {
    // 1. Try Memory (even expired)
    final memoryValue = await _memoryCache.getStale(key);
    if (memoryValue != null) {
      return memoryValue;
    }

    // 2. Try Disk (even expired)
    return _diskCache.getStale(key);
  }

  @override
  Future<void> put(String key, String value, {Duration? ttl}) async {
    await Future.wait([
      _memoryCache.put(key, value, ttl: ttl),
      _diskCache.put(key, value, ttl: ttl),
    ]);
  }

  @override
  Future<void> remove(String key) async {
    await _memoryCache.remove(key);
    await _diskCache.remove(key);
  }

  @override
  Future<void> clear() async {
    await _memoryCache.clear();
    await _diskCache.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    if (await _memoryCache.containsKey(key)) return true;
    return _diskCache.containsKey(key);
  }

  @override
  Future<void> removeMatching(String prefix) async {
    await _memoryCache.removeMatching(prefix);
    await _diskCache.removeMatching(prefix);
  }
}
