import 'package:json_annotation/json_annotation.dart';
import '../test_question.dart';
import 'question_type.dart';

part 'single_choice_question.g.dart';

@JsonSerializable()
class SingleChoiceQuestion extends TestQuestion {
  final List<String> options;
  final int correctOption;

  SingleChoiceQuestion({
    required String id,
    required String text,
    required this.options,
    required this.correctOption,
  }) : super(id: id, text: text, type: QuestionType.singleChoice);

  factory SingleChoiceQuestion.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SingleChoiceQuestionToJson(this);
}
