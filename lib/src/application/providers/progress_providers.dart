import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/progress_manager.dart';
import '../services/progress_manager.dart';
import '../services/progress_validator.dart';
import '../services/progress_aggregator.dart';
import '../services/progress_synchronizer.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../../infrastructure/providers/data_providers.dart';

// Провайдер ProgressValidator
final progressValidatorProvider = Provider<ProgressValidator>(
  (ref) => ProgressValidator(),
);

// Провайдер ProgressAggregator
final progressAggregatorProvider = Provider<ProgressAggregator>(
  (ref) => ProgressAggregator(),
);

// Провайдер ProgressSynchronizer
final progressSynchronizerProvider = Provider<ProgressSynchronizer>(
  (ref) => ProgressSynchronizer(),
);

// Провайдер ProgressManager
final progressManagerProvider = Provider<ProgressManager>((ref) {
  final dataService = ref.read(firestoreDataServiceProvider);
  final errorHandler = ref.read(errorHandlerProvider);
  return ProgressManagerImpl(
    dataService: dataService,
    errorHandler: errorHandler,
  );
});

// Провайдер текущего прогресса пользователя
final userProgressProvider = FutureProvider.family((ref, String userId) {
  final manager = ref.read(progressManagerProvider);
  return manager.getUserProgress(userId);
});

// Провайдер текущего уровня пользователя
final currentLevelProvider = Provider.family<int, String>((ref, userId) {
  final progress = ref
      .watch(userProgressProvider(userId))
      .maybeWhen(data: (p) => p, orElse: () => null);
  return progress?.summary.currentLevel ?? 1;
});

// Провайдер завершённых уровней
final completedLevelsProvider = Provider.family<List<int>, String>((
  ref,
  userId,
) {
  final progress = ref
      .watch(userProgressProvider(userId))
      .maybeWhen(data: (p) => p, orElse: () => null);
  return progress?.summary.completedLevels ?? [];
});

// Провайдер агрегированной статистики
final progressStatsProvider = Provider.family((ref, String userId) {
  final progress = ref
      .watch(userProgressProvider(userId))
      .maybeWhen(data: (p) => p, orElse: () => null);
  return progress?.summary;
});

// Провайдер для отслеживания изменений прогресса (реализация зависит от FirestoreDataService)
// TODO: Реализовать стрим изменений прогресса пользователя
