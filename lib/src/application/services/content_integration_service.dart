import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/level.dart';
import '../../domain/models/progress.dart';
import '../../domain/models/video.dart';
import '../../domain/models/test.dart';
import '../../domain/models/artifact.dart';
import 'video_service.dart';
import 'test_engine.dart';
import 'artifacts_manager.dart';
import 'progress_manager.dart';
import 'video_progress_tracker.dart';
import '../../domain/services/progress_manager.dart';
import '../../domain/models/download_state.dart';

/// Тип шага контента
enum ContentStepType { video, test, artifact }

/// Описание шага контента
class ContentStep {
  final ContentStepType type;
  final String id;
  ContentStep({required this.type, required this.id});
}

/// Сервис интеграции контента уровня
class ContentIntegrationService {
  final VideoService videoService;
  final TestEngine testEngine;
  final ArtifactsManager artifactsManager;
  final ProgressManager progressManager;
  final VideoProgressTracker videoProgressTracker;

  ContentIntegrationService({
    required this.videoService,
    required this.testEngine,
    required this.artifactsManager,
    required this.progressManager,
    required this.videoProgressTracker,
  });

  /// Получить все шаги контента уровня в нужной последовательности
  Future<List<ContentStep>> getContentSteps(LevelContents contents) async {
    final steps = <ContentStep>[];
    for (final videoId in contents.videoIds) {
      steps.add(ContentStep(type: ContentStepType.video, id: videoId));
    }
    for (final testId in contents.testIds) {
      steps.add(ContentStep(type: ContentStepType.test, id: testId));
    }
    for (final artifactId in contents.artifactIds) {
      steps.add(ContentStep(type: ContentStepType.artifact, id: artifactId));
    }
    return steps;
  }

  /// Получить текущий шаг пользователя в уровне
  Future<ContentStep?> getCurrentStep(
    String userId,
    String levelId,
    LevelContents contents,
  ) async {
    final progress = await progressManager.getUserProgress(userId);
    final steps = await getContentSteps(contents);
    for (final step in steps) {
      if (!_isStepCompleted(progress.levelProgress[levelId], step)) {
        return step;
      }
    }
    return null; // Все шаги завершены
  }

  /// Отметить шаг как завершённый
  Future<void> markStepCompleted(
    String userId,
    String levelId,
    ContentStep step, {
    int? testScore,
    Duration? videoPosition,
    Video? video,
    Artifact? artifact,
  }) async {
    switch (step.type) {
      case ContentStepType.video:
        if (video != null) {
          final position = videoPosition ?? Duration(seconds: video.duration);
          await videoProgressTracker.updateProgress(
            video: video,
            position: position,
          );
        }
        break;
      case ContentStepType.test:
        if (testScore != null) {
          await testEngine.updateTestProgress(testScore);
        }
        break;
      case ContentStepType.artifact:
        if (artifact != null) {
          // Запускаем загрузку и ждём завершения
          await for (final state in artifactsManager.startDownload(
            artifact,
            userId,
          )) {
            if (state.status == DownloadStatus.completed) break;
          }
        }
        break;
    }
    // Прогресс обновляется внутри соответствующих сервисов
  }

  /// Проверить, завершён ли шаг
  bool _isStepCompleted(LevelProgress? progress, ContentStep step) {
    if (progress == null) return false;
    switch (step.type) {
      case ContentStepType.video:
        return progress.videosWatched.contains(step.id);
      case ContentStepType.test:
        return progress.testsCompleted.containsKey(step.id);
      case ContentStepType.artifact:
        return progress.artifactsDownloaded.contains(step.id);
    }
  }

  /// Получить следующий шаг
  Future<ContentStep?> getNextStep(
    String userId,
    String levelId,
    LevelContents contents,
  ) async {
    final steps = await getContentSteps(contents);
    final progress = await progressManager.getUserProgress(userId);
    for (final step in steps) {
      if (!_isStepCompleted(progress.levelProgress[levelId], step)) {
        return step;
      }
    }
    return null;
  }

  /// Получить предыдущий завершённый шаг
  Future<ContentStep?> getPreviousStep(
    String userId,
    String levelId,
    LevelContents contents,
  ) async {
    final steps = await getContentSteps(contents);
    final progress = await progressManager.getUserProgress(userId);
    ContentStep? lastCompleted;
    for (final step in steps) {
      if (_isStepCompleted(progress.levelProgress[levelId], step)) {
        lastCompleted = step;
      } else {
        break;
      }
    }
    return lastCompleted;
  }
}
