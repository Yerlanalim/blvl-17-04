import '../../domain/models/achievement.dart';

class AchievementProgressTracker {
  /// Получить прогресс по достижению
  AchievementProgress getProgress(
    Achievement achievement,
    Map<String, dynamic> userData,
  ) {
    // TODO: реализовать расчет прогресса
    return AchievementProgress(
      achievementId: achievement.id,
      percent: 0.0,
      status: AchievementStatus.locked,
    );
  }
}
