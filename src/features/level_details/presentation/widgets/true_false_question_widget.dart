import 'package:flutter/material.dart';
import 'question_widget.dart';

/// Виджет для вопроса типа "верно/неверно"
class TrueFalseQuestionWidget extends QuestionWidget {
  final ValueChanged<bool> onChanged;
  final bool? value;

  const TrueFalseQuestionWidget({
    super.key,
    required super.questionText,
    required super.questionIndex,
    required super.totalQuestions,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для выбора верно/неверно
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questionText),
        // ... переключатель верно/неверно
      ],
    );
  }

  @override
  bool? getUserAnswer() => value;
}
