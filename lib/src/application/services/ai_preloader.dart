import '../../domain/models/cached_response.dart';
import '../../infrastructure/repositories/ai_cache_repository.dart';

/// Класс для упреждающей загрузки вероятных AI-ответов
class AIPreloader {
  final IAICacheRepository repository;

  AIPreloader(this.repository);

  /// Анализ паттернов вопросов пользователя (заглушка)
  List<String> predictNextQueries(List<String> history) {
    // TODO: Реализовать анализ паттернов (например, n-граммы, ML)
    if (history.isEmpty) return [];
    return [history.last]; // Простейший вариант: повтор последнего
  }

  /// Фоновая загрузка часто запрашиваемой информации
  Future<void> preload(
    List<String> queries,
    Future<String> Function(String) fetchAI,
  ) async {
    for (final query in queries) {
      // Проверяем, есть ли уже кэш
      final cached = await repository.getById(query.hashCode.toString());
      if (cached != null) continue;
      // Получаем ответ от AI (fetchAI — функция обращения к API)
      final response = await fetchAI(query);
      final now = DateTime.now();
      final cachedResponse = CachedResponse(
        id: query.hashCode.toString(),
        query: query,
        semanticHash: query.hashCode.toString(),
        response: response,
        createdAt: now,
        expiry: now.add(Duration(hours: 6)),
        relevance: 1.0,
        source: 'preloaded',
        meta: null,
      );
      await repository.put(cachedResponse);
    }
  }
}
