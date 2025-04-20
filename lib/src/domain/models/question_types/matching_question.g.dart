// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchingQuestion _$MatchingQuestionFromJson(Map<String, dynamic> json) =>
    MatchingQuestion(
      id: json['id'] as String,
      text: json['text'] as String,
      leftItems:
          (json['leftItems'] as List<dynamic>).map((e) => e as String).toList(),
      rightItems:
          (json['rightItems'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      correctMatches:
          (json['correctMatches'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
    );

Map<String, dynamic> _$MatchingQuestionToJson(MatchingQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'leftItems': instance.leftItems,
      'rightItems': instance.rightItems,
      'correctMatches': instance.correctMatches,
    };
