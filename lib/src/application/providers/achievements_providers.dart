import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/achievements_system.dart';
import '../services/achievements_system_impl.dart';
import '../../infrastructure/repositories/achievements_repository.dart';
import '../../infrastructure/providers/profile_providers.dart';
import '../services/achievement_condition_checker.dart';
import '../services/achievement_progress_tracker.dart';
import '../services/achievement_reward_distributor.dart';
import '../../application/providers/skills_providers.dart';
import '../../application/providers/progress_providers.dart';

final achievementsSystemProvider = Provider<IAchievementsSystem>((ref) {
  return AchievementsSystem(
    achievementsRepository: ref.watch(achievementsRepositoryProvider),
    profileRepository: ref.watch(profileRepositoryProvider),
    progressManager: ref.watch(progressManagerProvider),
    skillsManager: ref.watch(skillsManagerProvider),
    conditionChecker: AchievementConditionChecker(),
    progressTracker: AchievementProgressTracker(),
    rewardDistributor: AchievementRewardDistributor(
      skillsManager: ref.watch(skillsManagerProvider),
      profileRepository: ref.watch(profileRepositoryProvider),
    ),
  );
});

final achievementsListProvider = FutureProvider((ref) async {
  final system = ref.watch(achievementsSystemProvider);
  return system.getAvailableAchievements();
});

final userAchievementsProvider = FutureProvider.family((
  ref,
  String userId,
) async {
  final system = ref.watch(achievementsSystemProvider);
  return system.getUserAchievements(userId);
});

final achievementProgressProvider = FutureProvider.family((
  ref,
  Map<String, String> args,
) async {
  final system = ref.watch(achievementsSystemProvider);
  return system.getAchievementProgress(args['userId']!, args['achievementId']!);
});

final newAchievementsProvider = StreamProvider.family((ref, String userId) {
  final system = ref.watch(achievementsSystemProvider);
  return system.listenToAchievementEvents(userId);
});
