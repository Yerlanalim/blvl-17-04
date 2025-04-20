import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/single_choice_question_widget.dart';
import '../widgets/multiple_choice_question_widget.dart';
import '../widgets/text_input_question_widget.dart';
import '../widgets/matching_question_widget.dart';
import '../widgets/true_false_question_widget.dart';
import '../providers/test_ui_providers.dart';
import '../../../../../lib/src/domain/models/question_types/question_type.dart';
import '../../../../../lib/src/domain/models/question_types/single_choice_question.dart';
import '../../../../../lib/src/domain/models/question_types/multiple_choice_question.dart';
import '../../../../../lib/src/domain/models/question_types/matching_question.dart';
import 'test_results_screen.dart';

/// Экран прохождения теста
class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = ref.watch(currentQuestionProvider);
    final questionIndex = ref.watch(currentQuestionIndexProvider) ?? 0;
    final totalQuestions = ref.watch(totalQuestionsProvider) ?? 1;
    final isCompleted = ref.watch(isTestCompletedProvider);
    final controller = ref.watch(testScreenControllerProvider.notifier);

    if (isCompleted) {
      // Автоматический переход на экран результатов
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const TestResultsScreen()),
        );
      });
      return const SizedBox.shrink();
    }

    if (question == null) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget questionWidget;
    switch (question.type) {
      case QuestionType.singleChoice:
        final q = question as SingleChoiceQuestion;
        questionWidget = SingleChoiceQuestionWidget(
          questionText: q.text,
          questionIndex: questionIndex,
          totalQuestions: totalQuestions,
          options: q.options,
          onSelected: (index) {
            controller.saveAnswer(index);
          },
        );
        break;
      case QuestionType.multipleChoice:
        final q = question as MultipleChoiceQuestion;
        questionWidget = MultipleChoiceQuestionWidget(
          questionText: q.text,
          questionIndex: questionIndex,
          totalQuestions: totalQuestions,
          options: q.options,
          onSelectionChanged: (indices) {
            controller.saveAnswer(indices);
          },
        );
        break;
      case QuestionType.textInput:
        questionWidget = TextInputQuestionWidget(
          questionText: question.text,
          questionIndex: questionIndex,
          totalQuestions: totalQuestions,
          onTextChanged: (text) {
            controller.saveAnswer(text);
          },
        );
        break;
      case QuestionType.matching:
        final q = question as MatchingQuestion;
        questionWidget = MatchingQuestionWidget(
          questionText: q.text,
          questionIndex: questionIndex,
          totalQuestions: totalQuestions,
          leftItems: q.leftItems,
          rightItems: q.rightItems,
          onMatchChanged: (matches) {
            controller.saveAnswer(matches);
          },
        );
        break;
      case QuestionType.trueFalse:
        questionWidget = TrueFalseQuestionWidget(
          questionText: question.text,
          questionIndex: questionIndex,
          totalQuestions: totalQuestions,
          onChanged: (value) {
            controller.saveAnswer(value);
          },
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Тест')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Прогресс-бар
            LinearProgressIndicator(
              value: (questionIndex + 1) / totalQuestions,
            ),
            const SizedBox(height: 16),
            // Вопрос
            Expanded(child: questionWidget),
            const SizedBox(height: 16),
            // Кнопки навигации
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      questionIndex > 0
                          ? () {
                            controller.previousQuestion();
                          }
                          : null,
                  child: const Text('Назад'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (questionIndex < totalQuestions - 1) {
                      controller.nextQuestion();
                    } else {
                      controller.finishTest();
                    }
                  },
                  child: Text(
                    questionIndex < totalQuestions - 1 ? 'Далее' : 'Завершить',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
