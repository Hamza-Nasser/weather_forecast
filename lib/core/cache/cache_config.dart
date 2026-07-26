import 'package:injectable/injectable.dart';

/// Configuration for cache behavior.
@singleton
class CacheConfig {
  /// Maximum time-to-live for cache entries.
  final Duration defaultTtl;

  /// Maximum number of entries in memory cache.
  final int maxMemoryEntries;

  /// Name of the SQLite database file for disk cache.
  final String diskDatabaseName;

  /// Default constructor for custom configurations (e.g. in tests).
  const CacheConfig({
    this.defaultTtl = const Duration(minutes: 15),
    this.maxMemoryEntries = 100,
    this.diskDatabaseName = 'weather_cache.db',
  });

  /// Named constructor for GetIt dependency injection.
  /// Delegates to the default constructor to avoid value duplication.
  @factoryMethod
  const CacheConfig.defaultConfig() : this();
}
