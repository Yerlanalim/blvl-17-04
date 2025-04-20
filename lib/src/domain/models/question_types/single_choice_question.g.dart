// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_choice_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleChoiceQuestion _$SingleChoiceQuestionFromJson(
  Map<String, dynamic> json,
) => SingleChoiceQuestion(
  id: json['id'] as String,
  text: json['text'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctOption: (json['correctOption'] as num).toInt(),
);

Map<String, dynamic> _$SingleChoiceQuestionToJson(
  SingleChoiceQuestion instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'options': instance.options,
  'correctOption': instance.correctOption,
};
