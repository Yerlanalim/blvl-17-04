import '../../domain/models/cached_response.dart';

/// Трекер использования AI-кэша и API
class AIUsageTracker {
  int hits = 0;
  int misses = 0;
  final Map<String, int> queryFrequency = {};
  final Map<String, int> missFrequency = {};

  /// Зафиксировать попадание в кэш
  void recordHit(String query) {
    hits++;
    queryFrequency[query] = (queryFrequency[query] ?? 0) + 1;
  }

  /// Зафиксировать промах (обращение к API)
  void recordMiss(String query) {
    misses++;
    missFrequency[query] = (missFrequency[query] ?? 0) + 1;
  }

  /// Текущий hit/miss ratio
  double get hitMissRatio =>
      hits == 0 && misses == 0 ? 1.0 : hits / (hits + misses);

  /// Часто используемые запросы
  List<String> get mostFrequentQueries {
    final sorted =
        queryFrequency.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(10).map((e) => e.key).toList();
  }

  /// Часто промахивающиеся запросы
  List<String> get mostMissedQueries {
    final sorted =
        missFrequency.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(10).map((e) => e.key).toList();
  }
}
