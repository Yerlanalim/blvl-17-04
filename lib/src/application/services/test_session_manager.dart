import '../../domain/models/test_session.dart';
import '../../domain/models/test.dart';
import 'package:uuid/uuid.dart';

class TestSessionManager {
  final _uuid = Uuid();

  TestSession startSession(Test test, String userId) {
    return TestSession(
      sessionId: _uuid.v4(),
      testId: test.id,
      userId: userId,
      startedAt: DateTime.now(),
      finishedAt: null,
      answers: {},
      currentQuestionIndex: 0,
      isCompleted: false,
      score: null,
    );
  }

  // Для примера: восстановление сессии из хранилища (реализация зависит от инфраструктуры)
  Future<TestSession?> resumeSession(String sessionId) async {
    // TODO: реализовать восстановление из Firestore или кэша
    return null;
  }

  Future<void> saveSession(TestSession session) async {
    // TODO: реализовать сохранение в Firestore или кэш
  }
}
