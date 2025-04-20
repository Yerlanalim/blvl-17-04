import 'package:json_annotation/json_annotation.dart';
import '../test_question.dart';
import 'question_type.dart';

part 'true_false_question.g.dart';

@JsonSerializable()
class TrueFalseQuestion extends TestQuestion {
  final bool correctAnswer;

  TrueFalseQuestion({
    required String id,
    required String text,
    required this.correctAnswer,
  }) : super(id: id, text: text, type: QuestionType.trueFalse);

  factory TrueFalseQuestion.fromJson(Map<String, dynamic> json) =>
      _$TrueFalseQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TrueFalseQuestionToJson(this);
}
