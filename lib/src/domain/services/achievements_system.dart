abstract class IAchievementsSystem {
  /// Получить все доступные достижения (определения)
  Future<List<Achievement>> getAvailableAchievements();

  /// Получить достижения пользователя (полученные и прогресс)
  Future<List<Achievement>> getUserAchievements(String userId);

  /// Проверить условия получения достижений по событию
  Future<void> checkAchievementConditions(
    String userId,
    AchievementEvent event,
  );

  /// Обновить статус достижения (например, вручную или после проверки)
  Future<void> updateAchievementStatus(
    String userId,
    String achievementId,
    AchievementStatus status,
  );

  /// Получить прогресс по конкретному достижению
  Future<AchievementProgress> getAchievementProgress(
    String userId,
    String achievementId,
  );

  /// Подписка на события получения достижений
  Stream<AchievementEvent> listenToAchievementEvents(String userId);
}
