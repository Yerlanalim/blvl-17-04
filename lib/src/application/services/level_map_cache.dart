import '../../infrastructure/services/cache_manager.dart';
import '../../domain/models/level.dart';
import '../../infrastructure/models/level_connection.dart';

/// Кэш для карты уровней
/// Обеспечивает кэширование уровней и связей с помощью CacheManager.
class LevelMapCache {
  final CacheManager _cacheManager;
  static const String levelsKey = 'level_map_levels';
  static const String connectionsKey = 'level_map_connections';

  LevelMapCache(this._cacheManager);

  List<Level>? getLevels() => _cacheManager.get<List<Level>>(levelsKey);
  void setLevels(List<Level> levels, {int ttlSeconds = 300}) =>
      _cacheManager.set<List<Level>>(levelsKey, levels, ttlSeconds: ttlSeconds);
  void invalidateLevels() => _cacheManager.invalidate(levelsKey);

  List<LevelConnection>? getConnections() =>
      _cacheManager.get<List<LevelConnection>>(connectionsKey);
  void setConnections(
    List<LevelConnection> connections, {
    int ttlSeconds = 300,
  }) => _cacheManager.set<List<LevelConnection>>(
    connectionsKey,
    connections,
    ttlSeconds: ttlSeconds,
  );
  void invalidateConnections() => _cacheManager.invalidate(connectionsKey);

  void clear() {
    invalidateLevels();
    invalidateConnections();
  }
}
