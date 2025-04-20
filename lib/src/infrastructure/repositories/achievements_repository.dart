import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/achievement.dart';

abstract class IAchievementsRepository {
  /// Загрузить все определения достижений
  Future<List<Achievement>> fetchAllAchievements();

  /// Загрузить достижения пользователя
  Future<List<Achievement>> fetchUserAchievements(String userId);

  /// Сохранить/обновить статус достижения пользователя
  Future<void> updateUserAchievementStatus(
    String userId,
    String achievementId,
    AchievementStatus status,
  );

  /// Получить прогресс по достижению
  Future<AchievementProgress> fetchAchievementProgress(
    String userId,
    String achievementId,
  );
}

class FirestoreAchievementsRepository implements IAchievementsRepository {
  // TODO: внедрить зависимости Firestore, кэш, errorHandler

  @override
  Future<List<Achievement>> fetchAllAchievements() async {
    // TODO: реализовать загрузку из Firestore
    return [];
  }

  @override
  Future<List<Achievement>> fetchUserAchievements(String userId) async {
    // TODO: реализовать загрузку достижений пользователя
    return [];
  }

  @override
  Future<void> updateUserAchievementStatus(
    String userId,
    String achievementId,
    AchievementStatus status,
  ) async {
    // TODO: реализовать обновление статуса в Firestore
  }

  @override
  Future<AchievementProgress> fetchAchievementProgress(
    String userId,
    String achievementId,
  ) async {
    // TODO: реализовать получение прогресса
    return AchievementProgress(
      achievementId: achievementId,
      percent: 0.0,
      status: AchievementStatus.locked,
    );
  }
}

final achievementsRepositoryProvider = Provider<IAchievementsRepository>((ref) {
  // TODO: внедрить зависимости Firestore, кэш, errorHandler
  return FirestoreAchievementsRepository();
});
