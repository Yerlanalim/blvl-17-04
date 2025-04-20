import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/skills_manager.dart';
import '../../application/services/skills_manager_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../services/skill_calculator.dart';
import '../services/skills_progress_tracker.dart';
import '../services/skills_recommendation_engine.dart';
import '../../infrastructure/providers/profile_providers.dart';

// Провайдер для SkillsManager с внедрением зависимостей
final skillsManagerProvider = Provider<ISkillsManager>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return SkillsManager(
    profileRepository: profileRepository,
    skillCalculator: SkillCalculator(),
    progressTracker: SkillsProgressTracker(),
    recommendationEngine: SkillsRecommendationEngine(),
  );
});

// Провайдер для текущих навыков пользователя
final userSkillsProvider = FutureProvider.family<Map<String, int>, String>((
  ref,
  userId,
) {
  final manager = ref.watch(skillsManagerProvider);
  return manager.getCurrentSkills(userId);
});

// Провайдер для общей статистики по навыкам
final skillsStatsProvider = FutureProvider.family<Map<String, dynamic>, String>(
  (ref, userId) {
    final manager = ref.watch(skillsManagerProvider);
    return manager.getSkillsStats(userId);
  },
);

// Провайдер для рекомендаций по развитию навыков
final skillsRecommendationsProvider =
    FutureProvider.family<List<String>, String>((ref, userId) {
      final manager = ref.watch(skillsManagerProvider);
      return manager.getSkillRecommendations(userId);
    });

// Провайдер для истории изменений навыков
final skillsHistoryProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, userId) {
      final manager = ref.watch(skillsManagerProvider);
      return manager.getSkillsHistory(userId);
    });

// Провайдер для данных визуализации (например, для radar chart)
final skillsRadarDataProvider = FutureProvider.family<List<int>, String>((
  ref,
  userId,
) async {
  final stats = await ref.watch(skillsStatsProvider(userId).future);
  final skills = stats['skills'] as Map<String, int>? ?? {};
  // Преобразовать в список значений для визуализации
  return skills.values.toList();
});
