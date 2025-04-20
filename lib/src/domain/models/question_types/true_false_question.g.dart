// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'true_false_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrueFalseQuestion _$TrueFalseQuestionFromJson(Map<String, dynamic> json) =>
    TrueFalseQuestion(
      id: json['id'] as String,
      text: json['text'] as String,
      correctAnswer: json['correctAnswer'] as bool,
    );

Map<String, dynamic> _$TrueFalseQuestionToJson(TrueFalseQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'correctAnswer': instance.correctAnswer,
    };
