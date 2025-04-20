import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/score_display.dart';
import '../widgets/answer_review_widget.dart';
import '../widgets/feedback_widget.dart';
import '../providers/test_ui_providers.dart';

/// Экран отображения результатов теста
class TestResultsScreen extends ConsumerWidget {
  const TestResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: получить реальные значения из провайдеров
    final userAnswers = ref.watch(userAnswersProvider);
    // final correctAnswers = ... // Получить из TestEngine/test
    // final questions = ... // Получить из TestEngine/test
    // final score = ... // Получить из TestEngine/session
    // final maxScore = ... // Получить из TestEngine/test
    // final feedbackText = ... // Получить из TestEngine или сгенерировать

    return Scaffold(
      appBar: AppBar(title: const Text('Результаты теста')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TODO: заменить на реальные значения
            ScoreDisplay(score: 8, maxScore: 10),
            const SizedBox(height: 16),
            Expanded(
              child: AnswerReviewWidget(
                questions: const [],
                userAnswers: const [],
                correctAnswers: const [],
              ),
            ),
            const SizedBox(height: 16),
            FeedbackWidget(feedbackText: 'Молодец! Продолжай в том же духе.'),
          ],
        ),
      ),
    );
  }
}
