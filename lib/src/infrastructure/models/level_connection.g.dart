// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelConnection _$LevelConnectionFromJson(Map<String, dynamic> json) =>
    LevelConnection(
      id: json['id'] as String,
      sourceLevelId: json['sourceLevelId'] as String,
      targetLevelId: json['targetLevelId'] as String,
      direction: json['direction'] as String,
    );

Map<String, dynamic> _$LevelConnectionToJson(LevelConnection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceLevelId': instance.sourceLevelId,
      'targetLevelId': instance.targetLevelId,
      'direction': instance.direction,
    };
