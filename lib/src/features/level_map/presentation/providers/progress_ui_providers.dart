import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/services/progress_level_map_integrator.dart';
import '../../../../application/models/level_map_view_model.dart';
import '../../../../application/providers/progress_providers.dart';
import '../../../../application/providers/level_map_providers.dart';

// Провайдер для интегратора (можно заменить на реальный DI)
final progressLevelMapIntegratorProvider = Provider<ProgressLevelMapIntegrator>(
  (ref) {
    final progressManager = ref.watch(progressManagerProvider);
    final levelMapManager = ref.watch(levelMapManagerProvider);
    return ProgressLevelMapIntegrator(
      progressManager: progressManager,
      levelMapManager: levelMapManager,
    );
  },
);

// Провайдер для LevelMapViewModel с прогрессом (реактивный)
final progressLevelMapViewModelProvider =
    StreamProvider.family<LevelMapViewModel, String>((ref, userId) {
      final integrator = ref.watch(progressLevelMapIntegratorProvider);
      return integrator.watchLevelMapWithProgress(userId);
    });

// Провайдер для событий прогресса (достижения, разблокировка)
final progressEventsProvider = StreamProvider.autoDispose
    .family<ProgressEvent?, String>((ref, userId) {
      final integrator = ref.watch(progressLevelMapIntegratorProvider);
      return integrator.progressEvents;
    });
