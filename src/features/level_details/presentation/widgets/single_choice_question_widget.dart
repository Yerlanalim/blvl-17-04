import 'package:flutter/material.dart';
import 'question_widget.dart';

/// Виджет для вопроса с одним правильным ответом
class SingleChoiceQuestionWidget extends QuestionWidget {
  final List<String> options;
  final ValueChanged<int> onSelected;
  final int? selectedIndex;

  const SingleChoiceQuestionWidget({
    super.key,
    required super.questionText,
    required super.questionIndex,
    required super.totalQuestions,
    required this.options,
    required this.onSelected,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для выбора одного варианта
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questionText),
        // ... варианты ответов
      ],
    );
  }

  @override
  int? getUserAnswer() => selectedIndex;
}
