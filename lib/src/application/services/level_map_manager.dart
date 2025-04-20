import '../../domain/models/level.dart';
import '../../infrastructure/models/level_connection.dart';
import '../../domain/services/level_map_manager.dart' as iface;
import '../models/level_graph.dart';
import 'level_map_cache.dart';
import '../../infrastructure/repositories/firestore_level_repository.dart';
import '../../domain/models/progress.dart';
import 'package:meta/meta.dart';

/// Реализация LevelMapManager с кэшированием и графовой логикой
class LevelMapManager implements iface.LevelMapManager {
  final FirestoreLevelRepository levelRepository;
  final LevelMapCache cache;
  Progress? userProgress;
  bool isPremiumUser;

  LevelMapManager({
    required this.levelRepository,
    required this.cache,
    this.userProgress,
    this.isPremiumUser = false,
  });

  LevelGraph? _graph;

  /// Получить все уровни для карты (с кэшированием)
  /// Возвращает список всех уровней, используя кэш или репозиторий.
  @override
  Future<List<Level>> getAllLevels() async {
    var levels = cache.getLevels();
    if (levels == null) {
      levels = await levelRepository.getAll();
      cache.setLevels(levels);
    }
    return levels;
  }

  /// Получить связи между уровнями (с кэшированием)
  /// Возвращает список связей между уровнями в формате Map для совместимости с интерфейсом.
  @override
  Future<List<Map<String, dynamic>>> getLevelConnections() async {
    var connections = cache.getConnections();
    if (connections == null) {
      connections = await levelRepository.getLevelConnections();
      cache.setConnections(connections);
    }
    // Для совместимости с интерфейсом возвращаем Map
    return connections
        .map(
          (c) => {
            'id': c.id,
            'sourceLevelId': c.sourceLevelId,
            'targetLevelId': c.targetLevelId,
            'direction': c.direction,
          },
        )
        .toList();
  }

  /// Построить граф уровней (ленивая инициализация)
  /// Возвращает LevelGraph, построенный на основе уровней и связей.
  Future<LevelGraph> getGraph() async {
    if (_graph != null) return _graph!;
    final levels = await getAllLevels();
    final connections =
        cache.getConnections() ?? await levelRepository.getLevelConnections();
    final nodes = {for (var l in levels) l.id: l};
    _graph = LevelGraph(nodes: nodes, edges: connections);
    return _graph!;
  }

  /// Получить видимые уровни для viewport (пагинация)
  /// page — номер страницы, pageSize — размер страницы.
  Future<List<Level>> getVisibleLevels({
    int page = 0,
    int pageSize = 20,
  }) async {
    final levels = await getAllLevels();
    final start = page * pageSize;
    final end = (start + pageSize).clamp(0, levels.length);
    return levels.sublist(start, end);
  }

  /// Определить доступные уровни для пользователя
  /// Возвращает список уровней, которые доступны пользователю с учётом прогресса и премиум-статуса.
  Future<List<Level>> getAvailableLevels() async {
    final graph = await getGraph();
    if (userProgress == null) return [];
    final completed =
        userProgress!.summary.completedLevels.map((e) => e.toString()).toSet();
    final available = <Level>[];
    for (final level in graph.nodes.values) {
      if (level.isPremium && !isPremiumUser) continue;
      // Доступен, если предыдущий завершён или это первый уровень
      final isFirst = graph.edges.every((e) => e.targetLevelId != level.id);
      final unlocked =
          isFirst ||
          graph.edges.any(
            (e) =>
                e.targetLevelId == level.id &&
                completed.contains(e.sourceLevelId),
          );
      if (unlocked) available.add(level);
    }
    return available;
  }

  /// Определить заблокированные уровни
  /// Возвращает список уровней, которые заблокированы для пользователя.
  Future<List<Level>> getLockedLevels() async {
    final graph = await getGraph();
    final available = (await getAvailableLevels()).map((l) => l.id).toSet();
    return graph.nodes.values.where((l) => !available.contains(l.id)).toList();
  }

  /// Разблокировать уровень (заглушка)
  /// TODO: реализовать обновление прогресса пользователя для разблокировки уровня.
  Future<void> unlockLevel(String levelId) async {
    // TODO: реализовать обновление прогресса пользователя
  }

  /// Очистить кэш карты
  /// Очищает кэш и сбрасывает граф.
  void clearCache() {
    cache.clear();
    _graph = null;
  }

  /// Для тестов и внедрения зависимостей
  @visibleForTesting
  factory LevelMapManager.forTest({
    required FirestoreLevelRepository levelRepository,
    required LevelMapCache cache,
    Progress? userProgress,
    bool isPremiumUser = false,
  }) {
    return LevelMapManager(
      levelRepository: levelRepository,
      cache: cache,
      userProgress: userProgress,
      isPremiumUser: isPremiumUser,
    );
  }
}

// TODO: Интегрировать FirestoreDataService и ErrorHandler в levelRepositoryProvider для полноценной работы провайдеров карты уровней.
