import 'package:flutter/material.dart';

/// Абстрактный базовый виджет для вопроса
abstract class QuestionWidget extends StatelessWidget {
  final String questionText;
  final int questionIndex;
  final int totalQuestions;

  const QuestionWidget({
    super.key,
    required this.questionText,
    required this.questionIndex,
    required this.totalQuestions,
  });

  /// Метод для получения ответа пользователя
  dynamic getUserAnswer();
}
