// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  youtubeId: json['youtubeId'] as String,
  levelId: json['levelId'] as String,
  order: (json['order'] as num).toInt(),
  duration: (json['duration'] as num).toInt(),
);

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'youtubeId': instance.youtubeId,
  'levelId': instance.levelId,
  'order': instance.order,
  'duration': instance.duration,
};
