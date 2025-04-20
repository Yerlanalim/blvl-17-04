import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/firestore_level_repository.dart';
import '../services/firestore_data_service.dart';
import '../services/cache_manager.dart';
import '../../core/utils/error_handler.dart';
import '../../domain/models/level.dart';
import 'data_providers.dart';

final firestoreLevelRepositoryProvider = Provider<FirestoreLevelRepository>((
  ref,
) {
  final dataService = ref.read(firestoreDataServiceProvider);
  final cacheManager = ref.read(cacheManagerProvider);
  final errorHandler = ref.read(errorHandlerProvider);
  return FirestoreLevelRepository(
    dataService: dataService,
    cacheManager: cacheManager,
    errorHandler: errorHandler,
  );
});

final levelsProvider = FutureProvider<List<Level>>((ref) async {
  final repo = ref.read(firestoreLevelRepositoryProvider);
  return repo.getAll();
});

final premiumLevelsProvider = FutureProvider.family<List<Level>, bool>((
  ref,
  isPremium,
) async {
  final repo = ref.read(firestoreLevelRepositoryProvider);
  return repo.getByPremium(isPremium);
});
