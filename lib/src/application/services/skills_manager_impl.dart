import '../../domain/services/skills_manager.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../application/services/skill_calculator.dart';
import '../../application/services/skills_progress_tracker.dart';
import '../../application/services/skills_recommendation_engine.dart';

/// Реализация менеджера навыков пользователя
class SkillsManager implements ISkillsManager {
  final IProfileRepository profileRepository;
  final SkillCalculator skillCalculator;
  final SkillsProgressTracker progressTracker;
  final SkillsRecommendationEngine recommendationEngine;

  SkillsManager({
    required this.profileRepository,
    required this.skillCalculator,
    required this.progressTracker,
    required this.recommendationEngine,
  });

  @override
  Future<Map<String, int>> getCurrentSkills(String userId) async {
    final profile = await profileRepository.getProfile(userId);
    return profile?.skills ?? {};
  }

  @override
  Future<void> increaseSkills(
    String userId,
    Map<String, int> skillsDelta,
  ) async {
    // Получить текущие навыки
    final currentSkills = await getCurrentSkills(userId);
    // Рассчитать новые значения
    final updatedSkills = <String, int>{};
    skillsDelta.forEach((skillId, delta) {
      updatedSkills[skillId] = (currentSkills[skillId] ?? 0) + delta;
    });
    // Обновить навыки через ProfileRepository
    for (final entry in updatedSkills.entries) {
      await profileRepository.addOrUpdateSkill(userId, entry.key, entry.value);
      await progressTracker.trackSkillChange(
        userId: userId,
        skillId: entry.key,
        delta: skillsDelta[entry.key] ?? 0,
        timestamp: DateTime.now(),
      );
    }
  }

  @override
  Future<int> getTotalSkillLevel(String userId) async {
    final skills = await getCurrentSkills(userId);
    return skillCalculator.calculateTotalSkillLevel(skills);
  }

  @override
  Future<Map<String, dynamic>> getSkillsStats(String userId) async {
    final skills = await getCurrentSkills(userId);
    // Можно добавить расчет синергии, прогресса и т.д.
    return {
      'skills': skills,
      'totalLevel': skillCalculator.calculateTotalSkillLevel(skills),
      'synergy': skillCalculator.calculateSynergy(skills),
    };
  }

  @override
  Future<List<String>> getSkillRecommendations(String userId) async {
    final skills = await getCurrentSkills(userId);
    return recommendationEngine.generateRecommendations(
      userId: userId,
      currentSkills: skills,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getSkillsHistory(String userId) async {
    return progressTracker.getSkillsHistory(userId);
  }
}
