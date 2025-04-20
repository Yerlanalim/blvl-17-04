// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_input_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextInputQuestion _$TextInputQuestionFromJson(Map<String, dynamic> json) =>
    TextInputQuestion(
      id: json['id'] as String,
      text: json['text'] as String,
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$TextInputQuestionToJson(TextInputQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'correctAnswer': instance.correctAnswer,
    };
