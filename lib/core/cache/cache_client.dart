/// Abstract cache client interface.
///
/// All cache implementations (memory, disk) must conform to this contract.
/// This abstraction enables unit testing with mock implementations.
abstract class CacheClient {
  /// Retrieves a cached value by [key].
  ///
  /// Returns `null` if the key does not exist or has expired.
  Future<String?> get(String key);

  /// Stores a [value] under the given [key].
  ///
  /// If [ttl] is provided, the entry expires after that duration.
  /// Otherwise, the implementation's default TTL is used.
  Future<void> put(String key, String value, {Duration? ttl});

  /// Removes a single entry by [key].
  Future<void> remove(String key);

  /// Removes all entries from the cache.
  Future<void> clear();

  /// Returns `true` if a non-expired entry exists for [key].
  Future<bool> containsKey(String key);

  /// Removes all entries whose keys start with [prefix].
  Future<void> removeMatching(String prefix);

  /// Retrieves a cached value by [key], ignoring expiry.
  ///
  /// Returns `null` only if the key was never stored.
  /// Used for offline fallback — stale data is better than no data.
  Future<String?> getStale(String key);
}
