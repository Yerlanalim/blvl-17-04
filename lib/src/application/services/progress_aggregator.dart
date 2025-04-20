import '../../domain/models/progress.dart';

class ProgressAggregator {
  /// Рассчитать агрегированную статистику по всем уровням
  ProgressSummary aggregate(Map<String, LevelProgress> levelProgress) {
    int totalVideosWatched = 0;
    int totalTestsCompleted = 0;
    int totalArtifactsDownloaded = 0;
    List<int> completedLevels = [];
    int currentLevel = 1;
    DateTime lastUpdateTime = DateTime.now();

    for (final entry in levelProgress.entries) {
      final levelId = entry.key;
      final progress = entry.value;
      totalVideosWatched += progress.videosWatched.length;
      totalTestsCompleted += progress.testsCompleted.length;
      totalArtifactsDownloaded += progress.artifactsDownloaded.length;
      if (progress.completedAt != null) {
        // levelId предполагается числовым (level_1, level_2 и т.д.)
        final idNum = int.tryParse(levelId.replaceAll(RegExp(r'[^0-9]'), ''));
        if (idNum != null) {
          completedLevels.add(idNum);
          if (idNum > currentLevel) currentLevel = idNum;
        }
      }
      if (progress.completedAt != null &&
          progress.completedAt!.isAfter(lastUpdateTime)) {
        lastUpdateTime = progress.completedAt!;
      }
    }
    completedLevels.sort();
    return ProgressSummary(
      currentLevel: currentLevel,
      completedLevels: completedLevels,
      totalVideosWatched: totalVideosWatched,
      totalTestsCompleted: totalTestsCompleted,
      totalArtifactsDownloaded: totalArtifactsDownloaded,
      lastUpdateTime: lastUpdateTime,
    );
  }
}
