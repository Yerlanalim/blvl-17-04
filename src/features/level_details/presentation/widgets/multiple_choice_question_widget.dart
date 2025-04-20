import 'package:flutter/material.dart';
import 'question_widget.dart';

/// Виджет для вопроса с несколькими правильными ответами
class MultipleChoiceQuestionWidget extends QuestionWidget {
  final List<String> options;
  final ValueChanged<List<int>> onSelectionChanged;
  final List<int> selectedIndices;

  const MultipleChoiceQuestionWidget({
    super.key,
    required super.questionText,
    required super.questionIndex,
    required super.totalQuestions,
    required this.options,
    required this.onSelectionChanged,
    this.selectedIndices = const [],
  });

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для выбора нескольких вариантов
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questionText),
        // ... варианты ответов
      ],
    );
  }

  @override
  List<int> getUserAnswer() => selectedIndices;
}
