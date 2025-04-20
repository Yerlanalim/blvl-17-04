import '../models/video.dart';
import '../interfaces/base_repository.dart';

/// Интерфейс репозитория видео
abstract class VideoRepository extends BaseRepository<Video> {
  /// Получить видео по уровню
  Future<List<Video>> getByLevel(String levelId);
}
