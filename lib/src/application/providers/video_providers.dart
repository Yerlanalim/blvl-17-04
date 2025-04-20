import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/video_repository.dart';
import '../../domain/services/progress_manager.dart';
import '../services/video_service.dart';
import '../services/video_progress_tracker.dart';
import '../../infrastructure/repositories/firestore_video_repository.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import '../../infrastructure/services/cache_manager.dart';
import '../../infrastructure/providers/data_providers.dart';
import '../../application/providers/progress_providers.dart';

// Провайдер репозитория видео
final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  final dataService = ref.watch(firestoreDataServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider);
  return FirestoreVideoRepository(
    dataService: dataService,
    cacheManager: cacheManager,
  );
});

// Провайдер VideoService
final videoServiceProvider = Provider<VideoService>((ref) {
  final repo = ref.watch(videoRepositoryProvider);
  return VideoService(videoRepository: repo);
});

// Провайдер VideoProgressTracker (требует userId)
final videoProgressTrackerProvider =
    Provider.family<VideoProgressTracker, String>((ref, userId) {
      final progressManager = ref.watch(progressManagerProvider);
      return VideoProgressTracker(
        progressManager: progressManager,
        userId: userId,
      );
    });

// Провайдер текущего видео (state)
final currentVideoIdProvider = StateProvider<String?>((ref) => null);

// Провайдер состояния воспроизведения (stream)
final playbackStateProvider = StreamProvider.autoDispose((ref) {
  final service = ref.watch(videoServiceProvider);
  return service.playbackState;
});

// Провайдер истории просмотров (заглушка, можно расширить)
final videoHistoryProvider = StateProvider<List<String>>((ref) => []);

// ---
// Не забудь реализовать firestoreDataServiceProvider, cacheManagerProvider, progressManagerProvider в соответствующих местах.
