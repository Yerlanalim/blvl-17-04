import 'package:json_annotation/json_annotation.dart';
import '../test_question.dart';
import 'question_type.dart';

part 'multiple_choice_question.g.dart';

@JsonSerializable()
class MultipleChoiceQuestion extends TestQuestion {
  final List<String> options;
  final List<int> correctOptions;

  MultipleChoiceQuestion({
    required String id,
    required String text,
    required this.options,
    required this.correctOptions,
  }) : super(id: id, text: text, type: QuestionType.multipleChoice);

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) =>
      _$MultipleChoiceQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MultipleChoiceQuestionToJson(this);
}
