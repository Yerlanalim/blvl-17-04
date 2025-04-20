// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  levelId: json['levelId'] as String,
  videoId: json['videoId'] as String?,
  passingScore: (json['passingScore'] as num).toInt(),
  questions:
      (json['questions'] as List<dynamic>)
          .map((e) => TestQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'levelId': instance.levelId,
  'videoId': instance.videoId,
  'passingScore': instance.passingScore,
  'questions': instance.questions.map((e) => e.toJson()).toList(),
};
