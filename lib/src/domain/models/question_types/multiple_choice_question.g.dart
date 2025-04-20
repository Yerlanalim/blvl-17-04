// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_choice_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleChoiceQuestion _$MultipleChoiceQuestionFromJson(
  Map<String, dynamic> json,
) => MultipleChoiceQuestion(
  id: json['id'] as String,
  text: json['text'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctOptions:
      (json['correctOptions'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$MultipleChoiceQuestionToJson(
  MultipleChoiceQuestion instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'options': instance.options,
  'correctOptions': instance.correctOptions,
};
