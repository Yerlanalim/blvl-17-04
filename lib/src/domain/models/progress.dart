import 'package:json_annotation/json_annotation.dart';

part 'progress.g.dart';

/// Модель прогресса пользователя
@JsonSerializable(explicitToJson: true)
class Progress {
  /// ID пользователя
  final String userId;

  /// Агрегированная информация о прогрессе
  final ProgressSummary summary;

  /// Прогресс по уровням (levelId -> LevelProgress)
  final Map<String, LevelProgress> levelProgress;

  Progress({
    required this.userId,
    required this.summary,
    required this.levelProgress,
  });

  factory Progress.fromJson(Map<String, dynamic> json) =>
      _$ProgressFromJson(json);
  Map<String, dynamic> toJson() => _$ProgressToJson(this);
}

/// Агрегированная информация о прогрессе
@JsonSerializable()
class ProgressSummary {
  final int currentLevel;
  final List<int> completedLevels;
  final int totalVideosWatched;
  final int totalTestsCompleted;
  final int totalArtifactsDownloaded;
  final DateTime lastUpdateTime;

  ProgressSummary({
    required this.currentLevel,
    required this.completedLevels,
    required this.totalVideosWatched,
    required this.totalTestsCompleted,
    required this.totalArtifactsDownloaded,
    required this.lastUpdateTime,
  });

  factory ProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$ProgressSummaryToJson(this);
}

/// Прогресс по конкретному уровню
@JsonSerializable()
class LevelProgress {
  final List<String> videosWatched;
  final Map<String, int> testsCompleted;
  final List<String> artifactsDownloaded;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final double progressPercentage;

  LevelProgress({
    required this.videosWatched,
    required this.testsCompleted,
    required this.artifactsDownloaded,
    this.startedAt,
    this.completedAt,
    required this.progressPercentage,
  });

  factory LevelProgress.fromJson(Map<String, dynamic> json) =>
      _$LevelProgressFromJson(json);
  Map<String, dynamic> toJson() => _$LevelProgressToJson(this);
}
