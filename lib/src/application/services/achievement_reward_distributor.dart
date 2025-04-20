import '../../domain/models/achievement.dart';
import '../../domain/services/skills_manager.dart';
import '../../domain/repositories/profile_repository.dart';

class AchievementRewardDistributor {
  final ISkillsManager skillsManager;
  final IProfileRepository profileRepository;

  AchievementRewardDistributor({
    required this.skillsManager,
    required this.profileRepository,
  });

  /// Выдать награду за достижение
  Future<void> distributeReward(String userId, Achievement achievement) async {
    // TODO: реализовать выдачу наград (скиллы, баллы, визуальные элементы)
  }
}
