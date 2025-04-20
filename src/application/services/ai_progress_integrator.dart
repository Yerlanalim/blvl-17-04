import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'progress_analyzer.dart';
import 'learning_path_tracker.dart';
import 'content_recommender.dart';
import 'skill_gap_detector.dart';
import 'ai_recommendation_engine.dart';

/// Интегратор прогресса и ИИ-ассистента: связывает анализ прогресса с рекомендациями
class AIProgressIntegrator {
  // Зависимости: менеджеры прогресса, навыков, тестов, видео, ассистент
  final ProgressAnalyzer progressAnalyzer;
  final LearningPathTracker learningPathTracker;
  final ContentRecommender contentRecommender;
  final SkillGapDetector skillGapDetector;
  final AIRecommendationEngine recommendationEngine;

  AIProgressIntegrator({
    required this.progressAnalyzer,
    required this.learningPathTracker,
    required this.contentRecommender,
    required this.skillGapDetector,
    required this.recommendationEngine,
  });

  /// Анализирует текущий образовательный статус пользователя
  Future<UserLearningStatus> analyzeUserStatus(String userId) async {
    return await progressAnalyzer.analyze(userId);
  }

  /// Формирует персонализированные рекомендации на основе прогресса
  Future<List<AIRecommendation>> generateRecommendations(String userId) async {
    final status = await progressAnalyzer.analyze(userId);
    final skillGaps = await skillGapDetector.detect(userId);
    final path = await learningPathTracker.getLearningPath(userId);
    final content = await contentRecommender.recommend(userId);
    return await recommendationEngine.generate(
      status: status,
      skillGaps: skillGaps,
      path: path,
      content: content,
    );
  }

  /// Выявляет пробелы в знаниях и навыках пользователя
  Future<List<SkillGap>> detectSkillGaps(String userId) async {
    return await skillGapDetector.detect(userId);
  }
}
