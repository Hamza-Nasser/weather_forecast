import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/cache/cache_config.dart';
import 'package:weather_app/core/cache/cache_entry.dart';

/// Persistent disk cache implementation backed by SQLite via [sqflite].
///
/// Data survives app restarts. Suitable for caching API responses
/// that should persist across sessions.
@LazySingleton()
class DiskCacheClient implements CacheClient {
  final CacheConfig _config;
  Database? _database;

  /// Table name for cache entries.
  static const String _tableName = 'cache_entries';

  /// Creates a [DiskCacheClient].
  DiskCacheClient(this._config);

  /// Injects a database instance (primarily for testing).
  void setDatabaseForTesting(Database db) {
    _database = db;
  }

  /// Returns the database, initializing it if needed.
  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _config.diskDatabaseName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            key TEXT PRIMARY KEY,
            data TEXT NOT NULL,
            created_at INTEGER NOT NULL,
            expires_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Future<String?> get(String key) async {
    final db = await _db;
    final now = DateTime.now().millisecondsSinceEpoch;

    final results = await db.query(
      _tableName,
      where: 'key = ? AND expires_at > ?',
      whereArgs: [key, now],
    );

    if (results.isEmpty) {
      return null;
    }

    final entry = CacheEntry.fromMap(results.first);
    return entry.data;
  }

  @override
  Future<String?> getStale(String key) async {
    final db = await _db;

    final results = await db.query(
      _tableName,
      where: 'key = ?',
      whereArgs: [key],
    );

    if (results.isEmpty) return null;

    final entry = CacheEntry.fromMap(results.first);
    return entry.data;
  }

  @override
  Future<void> put(String key, String value, {Duration? ttl}) async {
    final db = await _db;
    final now = DateTime.now();
    final entry = CacheEntry(
      key: key,
      data: value,
      createdAt: now,
      expiresAt: now.add(ttl ?? _config.defaultTtl),
    );

    await db.insert(
      _tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await evictExpired();
  }

  @override
  Future<void> remove(String key) async {
    final db = await _db;
    await db.delete(_tableName, where: 'key = ?', whereArgs: [key]);
  }

  @override
  Future<void> clear() async {
    final db = await _db;
    await db.delete(_tableName);
  }

  @override
  Future<bool> containsKey(String key) async {
    final db = await _db;
    final now = DateTime.now().millisecondsSinceEpoch;

    final results = await db.query(
      _tableName,
      columns: ['key'],
      where: 'key = ? AND expires_at > ?',
      whereArgs: [key, now],
    );

    return results.isNotEmpty;
  }

  @override
  Future<void> removeMatching(String prefix) async {
    final db = await _db;
    final escapedPrefix = prefix
        .replaceAll('!', '!!')
        .replaceAll('%', '!%')
        .replaceAll('_', '!_');
    await db.delete(
      _tableName,
      where: "key LIKE ? ESCAPE '!'",
      whereArgs: ['$escapedPrefix%'],
    );
  }

  /// Removes all expired entries from the database.
  ///
  /// Can be called periodically or at app startup.
  Future<int> evictExpired() async {
    final db = await _db;
    final now = DateTime.now().millisecondsSinceEpoch;
    return db.delete(_tableName, where: 'expires_at <= ?', whereArgs: [now]);
  }

  /// Closes the database connection.
  Future<void> close() async {
    final db = await _db;
    await db.close();
    _database = null;
  }
}
