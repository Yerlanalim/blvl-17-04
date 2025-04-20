import '../../domain/models/test.dart';
import '../../domain/models/test_session.dart';
import '../../domain/models/test_question.dart';
import '../../domain/services/progress_manager.dart';
import '../../domain/models/progress.dart';

class TestEngine {
  final Test test;
  TestSession session;
  final ProgressManager progressManager;

  TestEngine({
    required this.test,
    required this.session,
    required this.progressManager,
  });

  TestQuestion get currentQuestion =>
      test.questions[session.currentQuestionIndex];

  bool get isCompleted => session.isCompleted;

  void answerCurrentQuestion(dynamic answer) {
    final questionId = currentQuestion.id;
    session.answers[questionId] = answer;
  }

  bool nextQuestion() {
    if (session.currentQuestionIndex < test.questions.length - 1) {
      session = TestSession(
        sessionId: session.sessionId,
        testId: session.testId,
        userId: session.userId,
        startedAt: session.startedAt,
        finishedAt: session.finishedAt,
        answers: session.answers,
        currentQuestionIndex: session.currentQuestionIndex + 1,
        isCompleted: false,
        score: session.score,
      );
      return true;
    } else {
      finishTest();
      return false;
    }
  }

  void finishTest() {
    session = TestSession(
      sessionId: session.sessionId,
      testId: session.testId,
      userId: session.userId,
      startedAt: session.startedAt,
      finishedAt: DateTime.now(),
      answers: session.answers,
      currentQuestionIndex: session.currentQuestionIndex,
      isCompleted: true,
      score: session.score,
    );
    // Интеграция с ProgressManager
    // updateTestProgress вызывается отдельно после подсчёта баллов
  }

  Future<void> updateTestProgress(int score) async {
    // Получаем текущий прогресс пользователя
    final progress = await progressManager.getUserProgress(session.userId);
    final levelId = test.levelId;
    final oldLevelProgress =
        progress.levelProgress[levelId] ??
        LevelProgress(
          videosWatched: [],
          testsCompleted: {},
          artifactsDownloaded: [],
          startedAt: DateTime.now(),
          completedAt: null,
          progressPercentage: 0.0,
        );
    final updatedTestsCompleted = Map<String, int>.from(
      oldLevelProgress.testsCompleted,
    );
    updatedTestsCompleted[test.id] = score;
    final updatedLevelProgress = LevelProgress(
      videosWatched: oldLevelProgress.videosWatched,
      testsCompleted: updatedTestsCompleted,
      artifactsDownloaded: oldLevelProgress.artifactsDownloaded,
      startedAt: oldLevelProgress.startedAt,
      completedAt: oldLevelProgress.completedAt,
      progressPercentage:
          oldLevelProgress.progressPercentage, // Можно обновить по логике
    );
    await progressManager.updateLevelProgress(
      session.userId,
      levelId,
      updatedLevelProgress,
    );
  }
}
