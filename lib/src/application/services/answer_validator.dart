import '../../domain/models/test_question.dart';
import '../../domain/models/question_types/single_choice_question.dart';
import '../../domain/models/question_types/multiple_choice_question.dart';
import '../../domain/models/question_types/text_input_question.dart';
import '../../domain/models/question_types/matching_question.dart';
import '../../domain/models/question_types/true_false_question.dart';
import '../../domain/models/question_types/question_type.dart';

class AnswerValidator {
  bool validate(TestQuestion question, dynamic answer) {
    switch (question.type) {
      case QuestionType.singleChoice:
        final q = question as SingleChoiceQuestion;
        return answer is int && answer == q.correctOption;
      case QuestionType.multipleChoice:
        final q = question as MultipleChoiceQuestion;
        if (answer is List<int>) {
          return _listsEqual(answer, q.correctOptions);
        }
        return false;
      case QuestionType.textInput:
        final q = question as TextInputQuestion;
        return answer is String &&
            answer.trim().toLowerCase() == q.correctAnswer.trim().toLowerCase();
      case QuestionType.matching:
        final q = question as MatchingQuestion;
        if (answer is List<int>) {
          return _listsEqual(answer, q.correctMatches);
        }
        return false;
      case QuestionType.trueFalse:
        final q = question as TrueFalseQuestion;
        return answer is bool && answer == q.correctAnswer;
    }
  }

  bool _listsEqual(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
