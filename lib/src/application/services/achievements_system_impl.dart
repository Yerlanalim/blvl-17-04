import '../../domain/services/achievements_system.dart';
import '../../domain/models/achievement.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/services/progress_manager.dart';
import '../../domain/services/skills_manager.dart';
import '../../infrastructure/repositories/achievements_repository.dart';
import 'achievement_condition_checker.dart';
import 'achievement_progress_tracker.dart';
import 'achievement_reward_distributor.dart';
import 'dart:async';

class AchievementsSystem implements IAchievementsSystem {
  final IAchievementsRepository achievementsRepository;
  final IProfileRepository profileRepository;
  final ProgressManager progressManager;
  final ISkillsManager skillsManager;

  final AchievementConditionChecker conditionChecker;
  final AchievementProgressTracker progressTracker;
  final AchievementRewardDistributor rewardDistributor;

  final StreamController<AchievementEvent> _eventController =
      StreamController.broadcast();

  AchievementsSystem({
    required this.achievementsRepository,
    required this.profileRepository,
    required this.progressManager,
    required this.skillsManager,
    required this.conditionChecker,
    required this.progressTracker,
    required this.rewardDistributor,
  });

  @override
  Future<List<Achievement>> getAvailableAchievements() async {
    return achievementsRepository.fetchAllAchievements();
  }

  @override
  Future<List<Achievement>> getUserAchievements(String userId) async {
    return achievementsRepository.fetchUserAchievements(userId);
  }

  @override
  Future<void> checkAchievementConditions(
    String userId,
    AchievementEvent event,
  ) async {
    final achievements = await achievementsRepository.fetchAllAchievements();
    final userAchievements = await achievementsRepository.fetchUserAchievements(
      userId,
    );
    for (final achievement in achievements) {
      final userProgress = await achievementsRepository
          .fetchAchievementProgress(userId, achievement.id);
      final alreadyUnlocked = userProgress.status == AchievementStatus.unlocked;
      if (!alreadyUnlocked &&
          conditionChecker.check(achievement, event, userProgress)) {
        await achievementsRepository.updateUserAchievementStatus(
          userId,
          achievement.id,
          AchievementStatus.unlocked,
        );
        await rewardDistributor.distributeReward(userId, achievement);
        _eventController.add(
          AchievementEvent(
            type: 'unlocked',
            payload: {'userId': userId, 'achievementId': achievement.id},
          ),
        );
      }
    }
  }

  @override
  Future<void> updateAchievementStatus(
    String userId,
    String achievementId,
    AchievementStatus status,
  ) async {
    await achievementsRepository.updateUserAchievementStatus(
      userId,
      achievementId,
      status,
    );
  }

  @override
  Future<AchievementProgress> getAchievementProgress(
    String userId,
    String achievementId,
  ) async {
    return achievementsRepository.fetchAchievementProgress(
      userId,
      achievementId,
    );
  }

  @override
  Stream<AchievementEvent> listenToAchievementEvents(String userId) {
    // TODO: фильтрация по userId
    return _eventController.stream;
  }

  void dispose() {
    _eventController.close();
  }
}
