import '../../domain/models/test.dart';
import '../../domain/models/test_session.dart';
import '../../domain/models/test_question.dart';
import 'answer_validator.dart';

class TestScorer {
  final AnswerValidator validator = AnswerValidator();

  int calculateScore(Test test, TestSession session) {
    int score = 0;
    for (final question in test.questions) {
      final answer = session.answers[question.id];
      if (validator.validate(question, answer)) {
        score++;
      }
    }
    return score;
  }

  bool isPassed(Test test, int score) {
    return score >= test.passingScore;
  }
}
