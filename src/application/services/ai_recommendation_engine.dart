import 'package:meta/meta.dart';
import 'progress_analyzer.dart';
import 'skill_gap_detector.dart';
import 'learning_path_tracker.dart';
import 'content_recommender.dart';

/// Движок генерации персонализированных рекомендаций для пользователя
class AIRecommendationEngine {
  /// Генерирует рекомендации на основе анализа статуса, пробелов и контента
  Future<List<AIRecommendation>> generate({
    required UserLearningStatus status,
    required List<SkillGap> skillGaps,
    required LearningPath path,
    required List<RecommendedContent> content,
  }) async {
    // Stub: формируем рекомендации по шагам, советам и материалам
    final recs = <AIRecommendation>[];
    // Совет по слабым темам
    for (final weak in status.weakTopics) {
      recs.add(
        AIRecommendation(
          text: 'Рекомендуем повторить тему: $weak',
          relevance: 0.9,
          type: RecommendationType.advice,
        ),
      );
    }
    // Совет по пробелам в навыках
    for (final gap in skillGaps) {
      recs.add(
        AIRecommendation(
          text:
              'Развивайте навык: ${gap.skillName} (до уровня ${gap.requiredLevel})',
          relevance: 0.85,
          type: RecommendationType.advice,
        ),
      );
    }
    // Материалы
    for (final mat in content) {
      recs.add(
        AIRecommendation(
          text: 'Изучите материал: ${mat.title}',
          relevance: mat.relevance,
          type: RecommendationType.material,
          materialId: mat.id,
        ),
      );
    }
    // Пошаговая инструкция (stub)
    recs.add(
      AIRecommendation(
        text: 'Шаг 1: Посмотрите видео "Основы бизнеса"',
        relevance: 0.8,
        type: RecommendationType.step,
        stepNumber: 1,
      ),
    );
    recs.add(
      AIRecommendation(
        text: 'Шаг 2: Пройдите тест "Проверка знаний"',
        relevance: 0.75,
        type: RecommendationType.step,
        stepNumber: 2,
      ),
    );
    return recs;
  }
}

enum RecommendationType { step, advice, material }

/// Персонализированная рекомендация для пользователя
class AIRecommendation {
  final String text;
  final double relevance;
  final RecommendationType type;
  final int? stepNumber;
  final String? materialId;

  AIRecommendation({
    required this.text,
    required this.relevance,
    required this.type,
    this.stepNumber,
    this.materialId,
  });
}
