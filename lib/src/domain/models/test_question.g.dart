// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestQuestion _$TestQuestionFromJson(Map<String, dynamic> json) => TestQuestion(
  id: json['id'] as String,
  text: json['text'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctOption: (json['correctOption'] as num).toInt(),
);

Map<String, dynamic> _$TestQuestionToJson(TestQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'options': instance.options,
      'correctOption': instance.correctOption,
    };
