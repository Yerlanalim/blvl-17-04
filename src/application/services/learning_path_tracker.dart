import 'package:meta/meta.dart';

/// Трекер образовательного пути пользователя
class LearningPathTracker {
  /// Возвращает путь пользователя (stub: 1 завершённый, 1 предстоящий уровень)
  Future<LearningPath> getLearningPath(String userId) async {
    // Stub: возвращаем фиктивный путь
    return LearningPath(
      completedLevels: ['level_1'],
      upcomingLevels: ['level_2'],
      completedTopics: ['Основы бизнеса'],
      upcomingTopics: ['Финансы'],
    );
  }
}

/// Образовательный путь пользователя
class LearningPath {
  final List<String> completedLevels;
  final List<String> upcomingLevels;
  final List<String> completedTopics;
  final List<String> upcomingTopics;

  LearningPath({
    required this.completedLevels,
    required this.upcomingLevels,
    required this.completedTopics,
    required this.upcomingTopics,
  });
}
