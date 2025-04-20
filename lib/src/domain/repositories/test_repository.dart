import '../models/test.dart';
import '../interfaces/base_repository.dart';

/// Интерфейс репозитория тестов
abstract class TestRepository extends BaseRepository<Test> {
  /// Получить тесты по уровню
  Future<List<Test>> getByLevel(String levelId);

  /// Получить тесты по видео
  Future<List<Test>> getByVideo(String videoId);
}
