/// Абстракция стратегии кэширования и простая реализация в памяти

abstract class CachingStrategy {
  T? get<T>(String key);
  void set<T>(String key, T value);
  void clear(String key);
  void clearAll();
}

class MemoryCachingStrategy implements CachingStrategy {
  final Map<String, dynamic> _cache = {};

  @override
  T? get<T>(String key) => _cache[key] as T?;

  @override
  void set<T>(String key, T value) => _cache[key] = value;

  @override
  void clear(String key) => _cache.remove(key);

  @override
  void clearAll() => _cache.clear();
}
