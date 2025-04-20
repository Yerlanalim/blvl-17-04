import '../../domain/models/cached_response.dart';
import '../../infrastructure/repositories/ai_cache_repository.dart';
import 'dart:async';

/// Менеджер кэширования AI-ответов с поддержкой семантического поиска и TTL
class AICacheManager {
  final IAICacheRepository repository;

  AICacheManager(this.repository);

  /// Получить кэшированный ответ по id
  Future<CachedResponse?> getById(String id) => repository.getById(id);

  /// Получить список похожих кэшированных ответов по семантическому хэшу
  Future<List<CachedResponse>> getBySemanticHash(
    String semanticHash, {
    double minRelevance = 0.7,
  }) => repository.getBySemanticHash(semanticHash, minRelevance: minRelevance);

  /// Сохранить ответ в кэш
  Future<void> put(CachedResponse response) => repository.put(response);

  /// Инвалидация по id
  Future<void> invalidate(String id) => repository.invalidate(id);

  /// Очистить весь кэш
  Future<void> clear() => repository.clear();

  /// Получить все кэшированные ответы
  Future<List<CachedResponse>> getAll() => repository.getAll();

  /// Проверить TTL (истек ли срок годности)
  bool isExpired(CachedResponse response) =>
      response.expiry.isBefore(DateTime.now());

  /// Оценить релевантность кэшированного ответа (заглушка, можно заменить на cosine similarity)
  double relevanceScore(String query, CachedResponse cached) {
    // TODO: реализовать семантическое сравнение (например, через эмбеддинги)
    return cached.relevance;
  }

  /// Найти наиболее релевантный кэшированный ответ для запроса
  Future<CachedResponse?> findBestMatch(
    String query,
    String semanticHash, {
    double minRelevance = 0.7,
  }) async {
    final candidates = await getBySemanticHash(
      semanticHash,
      minRelevance: minRelevance,
    );
    candidates.removeWhere(isExpired);
    if (candidates.isEmpty) return null;
    candidates.sort(
      (a, b) => relevanceScore(query, b).compareTo(relevanceScore(query, a)),
    );
    return candidates.first;
  }

  /// Инвалидация кэша по событию (например, обновление контента)
  Future<void> invalidateByMetaKey(String key, dynamic value) async {
    final all = await getAll();
    for (final resp in all) {
      if (resp.meta != null && resp.meta![key] == value) {
        await invalidate(resp.id);
      }
    }
  }

  /// Очередь отложенных запросов для оффлайн-режима
  final List<Function()> _deferredQueue = [];

  /// Добавить запрос в очередь для последующей синхронизации
  void enqueueDeferredRequest(Function() request) {
    _deferredQueue.add(request);
  }

  /// Выполнить все отложенные запросы (например, при восстановлении соединения)
  Future<void> processDeferredQueue() async {
    while (_deferredQueue.isNotEmpty) {
      final req = _deferredQueue.removeAt(0);
      await req();
    }
  }

  /// Получить базовый ответ без обращения к API (fallback)
  CachedResponse getFallbackResponse(String query) {
    return CachedResponse(
      id: query.hashCode.toString(),
      query: query,
      semanticHash: query.hashCode.toString(),
      response: 'Извините, сейчас нет соединения с сервером. Попробуйте позже.',
      createdAt: DateTime.now(),
      expiry: DateTime.now().add(Duration(minutes: 10)),
      relevance: 0.1,
      source: 'offline',
      meta: null,
    );
  }
}
