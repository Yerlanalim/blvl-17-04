import '../models/progress.dart';
import '../interfaces/base_repository.dart';

/// Интерфейс репозитория прогресса
abstract class ProgressRepository extends BaseRepository<Progress> {
  /// Получить прогресс пользователя по userId
  Future<Progress?> getByUserId(String userId);

  /// Обновить прогресс по уровню
  Future<void> updateLevelProgress(
    String userId,
    String levelId,
    LevelProgress progress,
  );
}
