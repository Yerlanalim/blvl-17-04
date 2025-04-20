// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestSession _$TestSessionFromJson(Map<String, dynamic> json) => TestSession(
  sessionId: json['sessionId'] as String,
  testId: json['testId'] as String,
  userId: json['userId'] as String,
  startedAt: DateTime.parse(json['startedAt'] as String),
  finishedAt:
      json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
  answers: json['answers'] as Map<String, dynamic>,
  currentQuestionIndex: (json['currentQuestionIndex'] as num).toInt(),
  isCompleted: json['isCompleted'] as bool,
  score: (json['score'] as num?)?.toInt(),
);

Map<String, dynamic> _$TestSessionToJson(TestSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'testId': instance.testId,
      'userId': instance.userId,
      'startedAt': instance.startedAt.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'answers': instance.answers,
      'currentQuestionIndex': instance.currentQuestionIndex,
      'isCompleted': instance.isCompleted,
      'score': instance.score,
    };
