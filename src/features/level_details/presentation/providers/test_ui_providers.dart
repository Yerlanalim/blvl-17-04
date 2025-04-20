import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/test_screen_controller.dart';
import '../../../../../lib/src/application/providers/test_providers.dart';
import '../../../../../lib/src/application/services/test_engine.dart';
import '../../../../../lib/src/domain/models/test_question.dart';

/// Провайдер контроллера экрана теста
final testScreenControllerProvider =
    ChangeNotifierProvider<TestScreenController>((ref) {
      return TestScreenController();
    });

/// Провайдер TestEngine (инициализация через application/providers)
final testEngineUiProvider = Provider<TestEngine?>((ref) {
  return ref.watch(testEngineProvider);
});

/// Провайдер текущего вопроса
final currentQuestionProvider = Provider<TestQuestion?>((ref) {
  final engine = ref.watch(testEngineUiProvider);
  return engine?.currentQuestion;
});

/// Провайдер индекса текущего вопроса
final currentQuestionIndexProvider = Provider<int?>((ref) {
  final engine = ref.watch(testEngineUiProvider);
  return engine?.session.currentQuestionIndex;
});

/// Провайдер общего количества вопросов
final totalQuestionsProvider = Provider<int?>((ref) {
  final engine = ref.watch(testEngineUiProvider);
  return engine?.test.questions.length;
});

/// Провайдер состояния завершения теста
final isTestCompletedProvider = Provider<bool>((ref) {
  final engine = ref.watch(testEngineUiProvider);
  return engine?.isCompleted ?? false;
});

/// Провайдер ответов пользователя
final userAnswersProvider = Provider<Map<String, dynamic>>((ref) {
  final engine = ref.watch(testEngineUiProvider);
  return engine?.session.answers ?? {};
});

// TODO: добавить провайдеры для получения теста, вопросов, состояния прохождения через TestEngine
