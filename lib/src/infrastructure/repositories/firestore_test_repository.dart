import '../../domain/models/test.dart';
import '../../domain/repositories/test_repository.dart';
import '../services/cache_manager.dart';

class FirestoreTestRepository extends TestRepository {
  final CacheManager cacheManager;
  // final FirestoreDataService dataService; // добавить при необходимости

  FirestoreTestRepository({required this.cacheManager});

  @override
  Future<List<Test>> getByLevel(String levelId) async {
    // Реализация получения тестов по уровню будет добавлена позже
    throw UnimplementedError();
  }

  @override
  Future<List<Test>> getByVideo(String videoId) async {
    // Реализация получения тестов по видео будет добавлена позже
    throw UnimplementedError();
  }

  @override
  Future<Test?> getById(String id) async {
    // Реализация получения теста по id будет добавлена позже
    throw UnimplementedError();
  }

  @override
  Future<List<Test>> getAll() async {
    throw UnimplementedError();
  }

  @override
  Future<Test> create(Test entity) async {
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, Test entity) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) async {
    throw UnimplementedError();
  }

  // Методы для загрузки вопросов, кэширования и оффлайн-режима будут добавлены позже
}
