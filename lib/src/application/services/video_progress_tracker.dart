import '../../domain/models/video.dart';
import '../../domain/services/progress_manager.dart';
import '../../domain/models/progress.dart';

class VideoProgressTracker {
  final ProgressManager progressManager;
  final String userId;

  VideoProgressTracker({required this.progressManager, required this.userId});

  /// Обновить прогресс просмотра видео
  Future<void> updateProgress({
    required Video video,
    required Duration position,
  }) async {
    final percent = getProgressPercent(video, position);
    final progress = await progressManager.getUserProgress(userId);
    final levelId = video.levelId;
    final levelProgress =
        progress.levelProgress[levelId] ??
        LevelProgress(
          videosWatched: [],
          testsCompleted: {},
          artifactsDownloaded: [],
          startedAt: DateTime.now(),
          completedAt: null,
          progressPercentage: 0.0,
        );
    // Если просмотрено >= 90% — добавить в videosWatched
    final watched = percent >= 0.9;
    final videosWatched = List<String>.from(levelProgress.videosWatched);
    if (watched && !videosWatched.contains(video.id)) {
      videosWatched.add(video.id);
    }
    final updated = LevelProgress(
      videosWatched: videosWatched,
      testsCompleted: levelProgress.testsCompleted,
      artifactsDownloaded: levelProgress.artifactsDownloaded,
      startedAt: levelProgress.startedAt ?? DateTime.now(),
      completedAt: watched ? DateTime.now() : levelProgress.completedAt,
      progressPercentage: percent,
    );
    await progressManager.updateLevelProgress(userId, levelId, updated);
  }

  /// Проверить, завершён ли просмотр видео (>=90%)
  bool isCompleted(Video video, Duration position) {
    return getProgressPercent(video, position) >= 0.9;
  }

  /// Получить процент просмотра (0..1)
  double getProgressPercent(Video video, Duration position) {
    if (video.duration == 0) return 0.0;
    return (position.inSeconds / video.duration).clamp(0.0, 1.0);
  }

  /// Сохранить позицию просмотра (например, в кэше или Firestore)
  Future<void> savePosition(String videoId, Duration position) async {
    // TODO: реализовать сохранение позиции (например, в Firestore или кэше)
  }

  /// Загрузить позицию просмотра
  Future<Duration> loadPosition(String videoId) async {
    // TODO: реализовать загрузку позиции (например, из Firestore или кэша)
    return Duration.zero;
  }
}
