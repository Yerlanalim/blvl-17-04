import 'package:meta/meta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../lib/src/domain/services/progress_manager.dart';
import '../../../lib/src/domain/services/skills_manager.dart';

/// Анализатор прогресса пользователя: определяет сильные и слабые стороны, текущий статус
class ProgressAnalyzer {
  final ProgressManager progressManager;
  final ISkillsManager skillsManager;

  ProgressAnalyzer({
    required this.progressManager,
    required this.skillsManager,
  });

  /// Анализирует прогресс пользователя и возвращает статус обучения
  Future<UserLearningStatus> analyze(String userId) async {
    final progress = await progressManager.getUserProgress(userId);
    // Stub: сильные темы — завершённые уровни, слабые — незавершённые
    final strongTopics =
        progress.summary.completedLevels.map((e) => 'Level $e').toList();
    final weakTopics = [
      if (!progress.summary.completedLevels.contains(
        progress.summary.currentLevel,
      ))
        'Level ${progress.summary.currentLevel}',
    ];
    return UserLearningStatus(
      currentLevel: progress.summary.currentLevel,
      strongTopics: strongTopics,
      weakTopics: weakTopics,
      totalVideosWatched: progress.summary.totalVideosWatched,
      totalTestsCompleted: progress.summary.totalTestsCompleted,
      totalArtifactsDownloaded: progress.summary.totalArtifactsDownloaded,
    );
  }
}

/// Статус обучения пользователя: сильные/слабые стороны, статистика
class UserLearningStatus {
  final int currentLevel;
  final List<String> strongTopics;
  final List<String> weakTopics;
  final int totalVideosWatched;
  final int totalTestsCompleted;
  final int totalArtifactsDownloaded;

  UserLearningStatus({
    required this.currentLevel,
    required this.strongTopics,
    required this.weakTopics,
    required this.totalVideosWatched,
    required this.totalTestsCompleted,
    required this.totalArtifactsDownloaded,
  });
}
