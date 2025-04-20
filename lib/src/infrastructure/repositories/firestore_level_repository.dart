import '../../domain/models/level.dart';
import '../../domain/repositories/level_repository.dart';
import '../services/firestore_data_service.dart';
import '../services/cache_manager.dart';
import '../../core/utils/error_handler.dart';
import '../models/level_connection.dart';

/// Реализация LevelRepository для Firestore с кэшированием
class FirestoreLevelRepository extends LevelRepository {
  final FirestoreDataService dataService;
  final CacheManager cacheManager;
  final ErrorHandler errorHandler;

  FirestoreLevelRepository({
    required this.dataService,
    required this.cacheManager,
    required this.errorHandler,
  });

  @override
  Future<List<Level>> getAll() async {
    const cacheKey = 'levels_all';
    try {
      // 1. Проверка кэша
      final cached = cacheManager.get<List<Level>>(cacheKey);
      if (cached != null && !cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      // 2. Получение из Firestore
      final levels = await dataService.getList<Level>('levels');
      cacheManager.set<List<Level>>(cacheKey, levels, ttlSeconds: 300);
      return levels;
    } catch (e, st) {
      errorHandler.handle(e, st);
      // 3. Офлайн-режим: если есть кэш — вернуть его
      final cached = cacheManager.get<List<Level>>(cacheKey);
      if (cached != null) return cached;
      rethrow;
    }
  }

  @override
  Future<Level?> getById(String id) async {
    final cacheKey = 'level_$id';
    try {
      final cached = cacheManager.get<Level>(cacheKey);
      if (cached != null && !cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      final level = await dataService.read<Level>('levels', id);
      if (level != null) {
        cacheManager.set<Level>(cacheKey, level, ttlSeconds: 300);
      }
      return level;
    } catch (e, st) {
      errorHandler.handle(e, st);
      final cached = cacheManager.get<Level>(cacheKey);
      if (cached != null) return cached;
      rethrow;
    }
  }

  @override
  Future<List<Level>> getByPremium(bool isPremium) async {
    final cacheKey = 'levels_premium_$isPremium';
    try {
      final cached = cacheManager.get<List<Level>>(cacheKey);
      if (cached != null && !cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      final allLevels = await getAll();
      final filtered =
          allLevels.where((l) => l.isPremium == isPremium).toList();
      cacheManager.set<List<Level>>(cacheKey, filtered, ttlSeconds: 300);
      return filtered;
    } catch (e, st) {
      errorHandler.handle(e, st);
      final cached = cacheManager.get<List<Level>>(cacheKey);
      if (cached != null) return cached;
      rethrow;
    }
  }

  @override
  Future<Level?> getNextLevel(String currentLevelId) async {
    try {
      final current = await getById(currentLevelId);
      if (current?.nextLevelId == null) return null;
      return await getById(current!.nextLevelId!);
    } catch (e, st) {
      errorHandler.handle(e, st);
      rethrow;
    }
  }

  /// Получить связи между уровнями
  Future<List<LevelConnection>> getLevelConnections() async {
    const cacheKey = 'level_connections';
    try {
      final cached = cacheManager.get<List<LevelConnection>>(cacheKey);
      if (cached != null && !cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      final connections = await dataService.getList<LevelConnection>(
        'level_connections',
      );
      cacheManager.set<List<LevelConnection>>(
        cacheKey,
        connections,
        ttlSeconds: 300,
      );
      return connections;
    } catch (e, st) {
      errorHandler.handle(e, st);
      final cached = cacheManager.get<List<LevelConnection>>(cacheKey);
      if (cached != null) return cached;
      rethrow;
    }
  }

  /// Получить уровни с пагинацией
  Future<List<Level>> getLevelsPaginated({
    int limit = 20,
    String? startAfterId,
  }) async {
    try {
      return await dataService.getList<Level>(
        'levels',
        limit: limit,
        startAfterId: startAfterId,
      );
    } catch (e, st) {
      errorHandler.handle(e, st);
      rethrow;
    }
  }

  /// Инвалидация кэша уровней
  void invalidateCache() {
    cacheManager.invalidate('levels_all');
    cacheManager.invalidate('level_connections');
    // Можно добавить инвалидацию по шаблону, если реализовано
  }

  /// Предзагрузка связанных уровней
  Future<void> preloadNeighborLevels(String levelId) async {
    try {
      final connections = await getLevelConnections();
      final neighbors = connections.where(
        (c) => c.sourceLevelId == levelId || c.targetLevelId == levelId,
      );
      for (final conn in neighbors) {
        final neighborId =
            conn.sourceLevelId == levelId
                ? conn.targetLevelId
                : conn.sourceLevelId;
        await getById(neighborId); // Кэширует уровень
      }
    } catch (e, st) {
      errorHandler.handle(e, st);
    }
  }

  /// Получить доступные уровни для пользователя (заглушка)
  Future<List<Level>> getAvailableLevels(String userId) async {
    // TODO: Реализовать с учётом прогресса пользователя
    return await getAll();
  }

  /// Получить заблокированные уровни для пользователя (заглушка)
  Future<List<Level>> getBlockedLevels(String userId) async {
    // TODO: Реализовать с учётом прогресса пользователя
    return [];
  }

  @override
  Future<Level> create(Level entity) async {
    // TODO: Реализация создания уровня
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, Level entity) async {
    // TODO: Реализация обновления уровня
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) async {
    // TODO: Реализация удаления уровня
    throw UnimplementedError();
  }
}
