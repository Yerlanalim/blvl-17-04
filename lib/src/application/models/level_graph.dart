import '../../domain/models/level.dart';
import '../../infrastructure/models/level_connection.dart';

/// Граф уровней для карты
/// Узлы — Level, рёбра — LevelConnection. Позволяет находить соседей и достижимые уровни.
class LevelGraph {
  final Map<String, Level> nodes;
  final List<LevelConnection> edges;
  final Map<String, List<String>> adjacency;

  /// Создаёт граф по списку уровней и связей
  LevelGraph({required this.nodes, required this.edges})
    : adjacency = _buildAdjacency(nodes, edges);

  /// Строит таблицу смежности для быстрого поиска соседей
  static Map<String, List<String>> _buildAdjacency(
    Map<String, Level> nodes,
    List<LevelConnection> edges,
  ) {
    final map = <String, List<String>>{};
    for (final edge in edges) {
      map.putIfAbsent(edge.sourceLevelId, () => []).add(edge.targetLevelId);
      // Для двунаправленных связей можно добавить обратное ребро
      // map.putIfAbsent(edge.targetLevelId, () => []).add(edge.sourceLevelId);
    }
    return map;
  }

  /// Получить соседей уровня по id
  List<Level> neighbors(String levelId) {
    final ids = adjacency[levelId] ?? [];
    return ids.map((id) => nodes[id]).whereType<Level>().toList();
  }

  /// Получить все уровни, достижимые из заданного (BFS)
  List<Level> reachableFrom(String startId) {
    final visited = <String>{};
    final queue = <String>[startId];
    final result = <Level>[];
    while (queue.isNotEmpty) {
      final id = queue.removeAt(0);
      if (!visited.add(id)) continue;
      final level = nodes[id];
      if (level != null) result.add(level);
      queue.addAll(adjacency[id] ?? []);
    }
    return result;
  }
}
