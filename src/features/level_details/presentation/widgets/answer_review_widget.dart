import 'package:flutter/material.dart';

/// Виджет для обзора правильных и неправильных ответов
class AnswerReviewWidget extends StatelessWidget {
  final List<dynamic> questions; // Список вопросов
  final List<dynamic> userAnswers; // Список ответов пользователя
  final List<dynamic> correctAnswers; // Список правильных ответов

  const AnswerReviewWidget({
    super.key,
    required this.questions,
    required this.userAnswers,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для обзора ответов
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Обзор ответов'),
        // ... список вопросов и сравнение ответов
      ],
    );
  }
}
