// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestQuestion _$TestQuestionFromJson(Map<String, dynamic> json) => TestQuestion(
  id: json['id'] as String,
  text: json['text'] as String,
  type: $enumDecode(_$QuestionTypeEnumMap, json['type']),
);

Map<String, dynamic> _$TestQuestionToJson(TestQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': _$QuestionTypeEnumMap[instance.type]!,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.textInput: 'textInput',
  QuestionType.matching: 'matching',
  QuestionType.trueFalse: 'trueFalse',
};
