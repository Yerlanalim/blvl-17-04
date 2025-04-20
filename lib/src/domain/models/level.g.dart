// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  order: (json['order'] as num).toInt(),
  isPremium: json['isPremium'] as bool,
  nextLevelId: json['nextLevelId'] as String?,
  contents: LevelContents.fromJson(json['contents'] as Map<String, dynamic>),
  skillsGained: (json['skillsGained'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
);

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'order': instance.order,
  'isPremium': instance.isPremium,
  'nextLevelId': instance.nextLevelId,
  'contents': instance.contents.toJson(),
  'skillsGained': instance.skillsGained,
};

LevelContents _$LevelContentsFromJson(
  Map<String, dynamic> json,
) => LevelContents(
  videoIds:
      (json['videoIds'] as List<dynamic>).map((e) => e as String).toList(),
  testIds: (json['testIds'] as List<dynamic>).map((e) => e as String).toList(),
  artifactIds:
      (json['artifactIds'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$LevelContentsToJson(LevelContents instance) =>
    <String, dynamic>{
      'videoIds': instance.videoIds,
      'testIds': instance.testIds,
      'artifactIds': instance.artifactIds,
    };
