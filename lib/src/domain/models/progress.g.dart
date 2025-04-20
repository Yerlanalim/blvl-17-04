// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Progress _$ProgressFromJson(Map<String, dynamic> json) => Progress(
  userId: json['userId'] as String,
  summary: ProgressSummary.fromJson(json['summary'] as Map<String, dynamic>),
  levelProgress: (json['levelProgress'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, LevelProgress.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$ProgressToJson(Progress instance) => <String, dynamic>{
  'userId': instance.userId,
  'summary': instance.summary.toJson(),
  'levelProgress': instance.levelProgress.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
};

ProgressSummary _$ProgressSummaryFromJson(Map<String, dynamic> json) =>
    ProgressSummary(
      currentLevel: (json['currentLevel'] as num).toInt(),
      completedLevels:
          (json['completedLevels'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      totalVideosWatched: (json['totalVideosWatched'] as num).toInt(),
      totalTestsCompleted: (json['totalTestsCompleted'] as num).toInt(),
      totalArtifactsDownloaded:
          (json['totalArtifactsDownloaded'] as num).toInt(),
      lastUpdateTime: DateTime.parse(json['lastUpdateTime'] as String),
    );

Map<String, dynamic> _$ProgressSummaryToJson(ProgressSummary instance) =>
    <String, dynamic>{
      'currentLevel': instance.currentLevel,
      'completedLevels': instance.completedLevels,
      'totalVideosWatched': instance.totalVideosWatched,
      'totalTestsCompleted': instance.totalTestsCompleted,
      'totalArtifactsDownloaded': instance.totalArtifactsDownloaded,
      'lastUpdateTime': instance.lastUpdateTime.toIso8601String(),
    };

LevelProgress _$LevelProgressFromJson(Map<String, dynamic> json) =>
    LevelProgress(
      videosWatched:
          (json['videosWatched'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      testsCompleted: Map<String, int>.from(json['testsCompleted'] as Map),
      artifactsDownloaded:
          (json['artifactsDownloaded'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      startedAt:
          json['startedAt'] == null
              ? null
              : DateTime.parse(json['startedAt'] as String),
      completedAt:
          json['completedAt'] == null
              ? null
              : DateTime.parse(json['completedAt'] as String),
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$LevelProgressToJson(LevelProgress instance) =>
    <String, dynamic>{
      'videosWatched': instance.videosWatched,
      'testsCompleted': instance.testsCompleted,
      'artifactsDownloaded': instance.artifactsDownloaded,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'progressPercentage': instance.progressPercentage,
    };
