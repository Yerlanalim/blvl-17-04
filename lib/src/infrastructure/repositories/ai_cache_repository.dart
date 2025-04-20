import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/cached_response.dart';

abstract class IAICacheRepository {
  Future<CachedResponse?> getById(String id);
  Future<List<CachedResponse>> getBySemanticHash(
    String semanticHash, {
    double minRelevance = 0.7,
  });
  Future<void> put(CachedResponse response);
  Future<void> invalidate(String id);
  Future<void> clear();
  Future<List<CachedResponse>> getAll();
}

/// Простейшая реализация: память + SharedPreferences (можно заменить на Hive)
class AICacheRepository implements IAICacheRepository {
  final _memoryCache = HashMap<String, CachedResponse>();
  final String _prefsKey = 'ai_cache_responses';

  @override
  Future<CachedResponse?> getById(String id) async {
    if (_memoryCache.containsKey(id)) {
      return _memoryCache[id];
    }
    final prefs = await SharedPreferences.getInstance();
    final all = prefs.getStringList(_prefsKey) ?? [];
    for (final item in all) {
      final map = Map<String, dynamic>.from(await compute(_decode, item));
      if (map['id'] == id) {
        final resp = CachedResponse.fromMap(map);
        _memoryCache[id] = resp;
        return resp;
      }
    }
    return null;
  }

  @override
  Future<List<CachedResponse>> getBySemanticHash(
    String semanticHash, {
    double minRelevance = 0.7,
  }) async {
    final all = await getAll();
    return all
        .where(
          (r) => r.semanticHash == semanticHash && r.relevance >= minRelevance,
        )
        .toList();
  }

  @override
  Future<void> put(CachedResponse response) async {
    _memoryCache[response.id] = response;
    final prefs = await SharedPreferences.getInstance();
    final all = prefs.getStringList(_prefsKey) ?? [];
    final updated = List<String>.from(
      all.where((item) {
        final map = Map<String, dynamic>.from(_decodeSync(item));
        return map['id'] != response.id;
      }),
    );
    updated.add(_encode(response.toMap()));
    await prefs.setStringList(_prefsKey, updated);
  }

  @override
  Future<void> invalidate(String id) async {
    _memoryCache.remove(id);
    final prefs = await SharedPreferences.getInstance();
    final all = prefs.getStringList(_prefsKey) ?? [];
    final updated =
        all.where((item) {
          final map = Map<String, dynamic>.from(_decodeSync(item));
          return map['id'] != id;
        }).toList();
    await prefs.setStringList(_prefsKey, updated);
  }

  @override
  Future<void> clear() async {
    _memoryCache.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }

  @override
  Future<List<CachedResponse>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final all = prefs.getStringList(_prefsKey) ?? [];
    return all.map((item) {
      final map = Map<String, dynamic>.from(_decodeSync(item));
      final resp = CachedResponse.fromMap(map);
      _memoryCache[resp.id] = resp;
      return resp;
    }).toList();
  }

  static String _encode(Map<String, dynamic> map) => map.toString();
  static Map<String, dynamic> _decodeSync(String str) => {};
  static Map<String, dynamic> _decode(String str) => {};
}
