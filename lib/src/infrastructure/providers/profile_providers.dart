import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/repositories/firestore_profile_repository.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/firestore_data_service.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/cache_manager.dart';
import 'package:blvl_17_04_tmp/src/core/utils/error_handler.dart';
import 'package:blvl_17_04_tmp/src/domain/models/user_profile.dart';
import 'package:blvl_17_04_tmp/src/domain/models/business_info.dart';

final profileRepositoryProvider = Provider<FirestoreProfileRepository>((ref) {
  final firestoreDataService = ref.watch(firestoreDataServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider);
  final errorHandler = ref.watch(errorHandlerProvider);
  return FirestoreProfileRepository(
    firestoreDataService: firestoreDataService,
    cacheManager: cacheManager,
    errorHandler: errorHandler,
  );
});

final userProfileProvider = FutureProvider.family<UserProfile?, String>((
  ref,
  userId,
) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile(userId);
});

final userProfileStreamProvider = StreamProvider.family<UserProfile?, String>((
  ref,
  userId,
) {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.watchProfile(userId);
});

final businessInfoProvider = Provider.family<BusinessInfo?, String>((
  ref,
  userId,
) {
  final profile = ref
      .watch(userProfileProvider(userId))
      .maybeWhen(data: (profile) => profile, orElse: () => null);
  return profile?.businessInfo;
});

final userSkillsProvider = Provider.family<Map<String, int>?, String>((
  ref,
  userId,
) {
  final profile = ref
      .watch(userProfileProvider(userId))
      .maybeWhen(data: (profile) => profile, orElse: () => null);
  return profile?.skills;
});

final userAchievementsProvider = Provider.family<List<String>?, String>((
  ref,
  userId,
) {
  final profile = ref
      .watch(userProfileProvider(userId))
      .maybeWhen(data: (profile) => profile, orElse: () => null);
  return profile?.achievements;
});

// Провайдеры зависимостей (заглушки, если их нет)
final firestoreDataServiceProvider = Provider<FirestoreDataService>(
  (ref) => throw UnimplementedError(),
);
final cacheManagerProvider = Provider<CacheManager>(
  (ref) => throw UnimplementedError(),
);
