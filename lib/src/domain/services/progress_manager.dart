import '../models/progress.dart';

/// Интерфейс ProgressManager для управления прогрессом пользователя
abstract class ProgressManager {
  /// Получить прогресс пользователя
  Future<Progress> getUserProgress(String userId);

  /// Обновить прогресс по уровню
  Future<void> updateLevelProgress(
    String userId,
    String levelId,
    LevelProgress progress,
  );

  /// Сбросить прогресс пользователя
  Future<void> resetProgress(String userId);
}
