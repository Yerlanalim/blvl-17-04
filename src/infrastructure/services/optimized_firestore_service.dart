/// OptimizedFirestoreService: сервис для оптимизированной работы с Firestore
/// Включает batch, кэширование, оптимизацию структуры запросов

import 'package:cloud_firestore/cloud_firestore.dart';
import 'caching_strategy.dart';

class OptimizedFirestoreService {
  final FirebaseFirestore _firestore;
  final CachingStrategy _cache;

  OptimizedFirestoreService(this._firestore, this._cache);

  Future<T?> getDocument<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final cached = _cache.get<T>(path);
    if (cached != null) return cached;
    final doc = await _firestore.doc(path).get();
    if (doc.exists) {
      final data = fromJson(doc.data()!);
      _cache.set(path, data);
      return data;
    }
    return null;
  }

  Future<void> setDocument<T>(String path, Map<String, dynamic> data) async {
    await _firestore.doc(path).set(data);
    _cache.set(path, data);
  }

  Future<void> batchWrite(Map<String, Map<String, dynamic>> updates) async {
    final batch = _firestore.batch();
    updates.forEach((path, data) {
      batch.set(_firestore.doc(path), data);
      _cache.set(path, data);
    });
    await batch.commit();
  }

  // TODO: Добавить методы для оптимизации запросов (ограничение полей, фильтрация, агрегация)
}
