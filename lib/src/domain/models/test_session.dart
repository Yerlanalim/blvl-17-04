import 'package:json_annotation/json_annotation.dart';
import 'test.dart';

part 'test_session.g.dart';

@JsonSerializable()
class TestSession {
  final String sessionId;
  final String testId;
  final String userId;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final Map<String, dynamic> answers; // questionId -> answer
  final int currentQuestionIndex;
  final bool isCompleted;
  final int? score;

  TestSession({
    required this.sessionId,
    required this.testId,
    required this.userId,
    required this.startedAt,
    this.finishedAt,
    required this.answers,
    required this.currentQuestionIndex,
    required this.isCompleted,
    this.score,
  });

  factory TestSession.fromJson(Map<String, dynamic> json) =>
      _$TestSessionFromJson(json);
  Map<String, dynamic> toJson() => _$TestSessionToJson(this);
}
