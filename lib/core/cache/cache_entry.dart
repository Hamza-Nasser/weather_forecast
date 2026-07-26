/// Represents a single cache entry with metadata.
class CacheEntry {
  /// The unique key identifying this entry.
  final String key;

  /// The cached data as a JSON string.
  final String data;

  /// When this entry was created.
  final DateTime createdAt;

  /// When this entry expires.
  final DateTime expiresAt;

  const CacheEntry({
    required this.key,
    required this.data,
    required this.createdAt,
    required this.expiresAt,
  });

  /// Whether this entry has expired.
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Creates a [CacheEntry] from a database row map.
  factory CacheEntry.fromMap(Map<String, dynamic> map) {
    return CacheEntry(
      key: map['key'] as String,
      data: map['data'] as String,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      expiresAt:
          DateTime.fromMillisecondsSinceEpoch(map['expires_at'] as int),
    );
  }

  /// Converts this entry to a map suitable for database insertion.
  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'data': data,
      'created_at': createdAt.millisecondsSinceEpoch,
      'expires_at': expiresAt.millisecondsSinceEpoch,
    };
  }
}
