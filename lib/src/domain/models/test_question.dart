import 'package:json_annotation/json_annotation.dart';
import 'question_types/question_type.dart';
import 'question_types/single_choice_question.dart';
import 'question_types/multiple_choice_question.dart';
import 'question_types/text_input_question.dart';
import 'question_types/matching_question.dart';
import 'question_types/true_false_question.dart';

part 'test_question.g.dart';

/// Модель вопроса теста
@JsonSerializable()
abstract class TestQuestion {
  /// Идентификатор вопроса
  final String id;

  /// Текст вопроса
  final String text;

  /// Тип вопроса
  final QuestionType type;

  TestQuestion({required this.id, required this.text, required this.type});

  factory TestQuestion.fromJson(Map<String, dynamic> json) {
    final type = QuestionType.values.firstWhere(
      (e) => e.toString() == 'QuestionType.' + (json['type'] as String),
      orElse: () => QuestionType.singleChoice,
    );
    switch (type) {
      case QuestionType.singleChoice:
        return SingleChoiceQuestion.fromJson(json);
      case QuestionType.multipleChoice:
        return MultipleChoiceQuestion.fromJson(json);
      case QuestionType.textInput:
        return TextInputQuestion.fromJson(json);
      case QuestionType.matching:
        return MatchingQuestion.fromJson(json);
      case QuestionType.trueFalse:
        return TrueFalseQuestion.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}
