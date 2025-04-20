import 'package:json_annotation/json_annotation.dart';
import '../test_question.dart';
import 'question_type.dart';

part 'text_input_question.g.dart';

@JsonSerializable()
class TextInputQuestion extends TestQuestion {
  final String correctAnswer;

  TextInputQuestion({
    required String id,
    required String text,
    required this.correctAnswer,
  }) : super(id: id, text: text, type: QuestionType.textInput);

  factory TextInputQuestion.fromJson(Map<String, dynamic> json) =>
      _$TextInputQuestionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TextInputQuestionToJson(this);
}
