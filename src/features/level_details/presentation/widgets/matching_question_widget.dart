import 'package:flutter/material.dart';
import 'question_widget.dart';

/// Виджет для вопроса на соответствие
class MatchingQuestionWidget extends QuestionWidget {
  final List<String> leftItems;
  final List<String> rightItems;
  final ValueChanged<Map<int, int>> onMatchChanged;
  final Map<int, int> matches;

  const MatchingQuestionWidget({
    super.key,
    required super.questionText,
    required super.questionIndex,
    required super.totalQuestions,
    required this.leftItems,
    required this.rightItems,
    required this.onMatchChanged,
    this.matches = const {},
  });

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для сопоставления элементов
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questionText),
        // ... UI для сопоставления
      ],
    );
  }

  @override
  Map<int, int> getUserAnswer() => matches;
}
