import 'package:json_annotation/json_annotation.dart';

part 'test_question.g.dart';

/// Модель вопроса теста
@JsonSerializable()
class TestQuestion {
  /// Идентификатор вопроса
  final String id;

  /// Текст вопроса
  final String text;

  /// Варианты ответов
  final List<String> options;

  /// Индекс правильного ответа
  final int correctOption;

  TestQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOption,
  });

  factory TestQuestion.fromJson(Map<String, dynamic> json) =>
      _$TestQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$TestQuestionToJson(this);
}
