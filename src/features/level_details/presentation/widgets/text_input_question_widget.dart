import 'package:flutter/material.dart';
import 'question_widget.dart';

/// Виджет для вопроса с вводом текста
class TextInputQuestionWidget extends QuestionWidget {
  final ValueChanged<String> onTextChanged;
  final String? initialValue;

  const TextInputQuestionWidget({
    super.key,
    required super.questionText,
    required super.questionIndex,
    required super.totalQuestions,
    required this.onTextChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для ввода текста
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questionText),
        // ... поле для ввода текста
      ],
    );
  }

  @override
  String? getUserAnswer() => initialValue;
}
