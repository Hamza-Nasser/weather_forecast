import 'package:injectable/injectable.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/cache/cache_config.dart';
import 'package:weather_app/core/cache/cache_entry.dart';

/// In-memory cache implementation using a [Map].
///
/// Suitable for short-lived data that should not survive app restarts.
/// Automatically evicts expired entries and respects [CacheConfig.maxMemoryEntries].
@singleton
class MemoryCacheClient implements CacheClient {
  final CacheConfig _config;
  final Map<String, CacheEntry> _store = {};

  MemoryCacheClient(this._config);

  @override
  Future<String?> get(String key) async {
    final entry = _store[key];
    if (entry == null) return null;

    if (entry.isExpired) {
      _store.remove(key);
      return null;
    }

    return entry.data;
  }

  @override
  Future<String?> getStale(String key) async {
    final entry = _store[key];
    return entry?.data;
  }

  @override
  Future<void> put(String key, String value, {Duration? ttl}) async {
    // Evict oldest entries if at capacity
    if (_store.length >= _config.maxMemoryEntries && !_store.containsKey(key)) {
      _evictOldest();
    }

    final now = DateTime.now();
    _store[key] = CacheEntry(
      key: key,
      data: value,
      createdAt: now,
      expiresAt: now.add(ttl ?? _config.defaultTtl),
    );
  }

  @override
  Future<void> remove(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> clear() async {
    _store.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    final entry = _store[key];
    if (entry == null) return false;

    if (entry.isExpired) {
      _store.remove(key);
      return false;
    }

    return true;
  }

  @override
  Future<void> removeMatching(String prefix) async {
    _store.removeWhere((key, _) => key.startsWith(prefix));
  }

  void _evictOldest() {
    // First, remove any expired entries
    _store.removeWhere((_, entry) => entry.isExpired);

    // If still at capacity, remove the oldest by creation time
    if (_store.length >= _config.maxMemoryEntries) {
      final oldestKey = _store.entries
          .reduce(
            (a, b) => a.value.createdAt.isBefore(b.value.createdAt) ? a : b,
          )
          .key;
      _store.remove(oldestKey);
    }
  }
}
