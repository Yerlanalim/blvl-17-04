import '../../domain/models/cached_response.dart';

abstract class CacheInvalidationStrategy {
  bool shouldInvalidate(CachedResponse response);
}

/// Инвалидация по TTL
class TtlInvalidationStrategy implements CacheInvalidationStrategy {
  @override
  bool shouldInvalidate(CachedResponse response) =>
      response.expiry.isBefore(DateTime.now());
}

/// Инвалидация по событию (например, обновление контента)
class EventInvalidationStrategy implements CacheInvalidationStrategy {
  final String metaKey;
  final dynamic metaValue;
  EventInvalidationStrategy(this.metaKey, this.metaValue);
  @override
  bool shouldInvalidate(CachedResponse response) =>
      response.meta != null && response.meta![metaKey] == metaValue;
}

/// Инвалидация по LRU (заглушка, требует поддержки lastUsed)
class LruInvalidationStrategy implements CacheInvalidationStrategy {
  @override
  bool shouldInvalidate(CachedResponse response) {
    // TODO: реализовать на основе lastUsed
    return false;
  }
}
