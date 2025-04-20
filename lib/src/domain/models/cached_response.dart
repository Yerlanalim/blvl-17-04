import 'package:cloud_firestore/cloud_firestore.dart';

/// Модель кэшированного ответа ИИ
class CachedResponse {
  /// Уникальный идентификатор (например, хэш запроса)
  final String id;

  /// Оригинальный текст запроса
  final String query;

  /// Семантический хэш/вектор запроса (для поиска похожих)
  final String semanticHash;

  /// Ответ ИИ
  final String response;

  /// Время создания
  final DateTime createdAt;

  /// Время истечения TTL
  final DateTime expiry;

  /// Оценка релевантности (0..1)
  final double relevance;

  /// Источник (memory, disk, preloaded, offline)
  final String source;

  /// Дополнительные метаданные (например, тема, userId)
  final Map<String, dynamic>? meta;

  CachedResponse({
    required this.id,
    required this.query,
    required this.semanticHash,
    required this.response,
    required this.createdAt,
    required this.expiry,
    required this.relevance,
    required this.source,
    this.meta,
  });

  factory CachedResponse.fromMap(Map<String, dynamic> map) {
    return CachedResponse(
      id: map['id'] ?? '',
      query: map['query'] ?? '',
      semanticHash: map['semanticHash'] ?? '',
      response: map['response'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      expiry: (map['expiry'] as Timestamp).toDate(),
      relevance: (map['relevance'] as num?)?.toDouble() ?? 1.0,
      source: map['source'] ?? 'memory',
      meta: map['meta'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': query,
      'semanticHash': semanticHash,
      'response': response,
      'createdAt': Timestamp.fromDate(createdAt),
      'expiry': Timestamp.fromDate(expiry),
      'relevance': relevance,
      'source': source,
      'meta': meta,
    };
  }
}
