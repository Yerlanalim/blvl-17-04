import 'package:json_annotation/json_annotation.dart';
import '../test_question.dart';
import 'question_type.dart';

part 'matching_question.g.dart';

@JsonSerializable()
class MatchingQuestion extends TestQuestion {
  final List<String> leftItems;
  final List<String> rightItems;
  final List<int> correctMatches;

  MatchingQuestion({
    required String id,
    required String text,
    required this.leftItems,
    required this.rightItems,
    required this.correctMatches,
  }) : super(id: id, text: text, type: QuestionType.matching);

  factory MatchingQuestion.fromJson(Map<String, dynamic> json) =>
      _$MatchingQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MatchingQuestionToJson(this);
}
