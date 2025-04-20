import 'package:meta/meta.dart';

/// Рекомендатель учебных материалов на основе прогресса пользователя
class ContentRecommender {
  /// Рекомендует учебные материалы (stub: возвращает 2 материала)
  Future<List<RecommendedContent>> recommend(String userId) async {
    // Stub: возвращаем 2 материала
    return [
      RecommendedContent(
        id: 'video_1',
        type: ContentType.video,
        title: 'Видео: Основы бизнеса',
        relevance: 0.95,
        description: 'Рекомендуемое видео для вашего уровня',
      ),
      RecommendedContent(
        id: 'test_1',
        type: ContentType.test,
        title: 'Тест: Проверка знаний',
        relevance: 0.85,
        description: 'Тест для закрепления материала',
      ),
    ];
  }
}

enum ContentType { video, test, artifact }

/// Рекомендованный учебный материал
class RecommendedContent {
  final String id;
  final ContentType type;
  final String title;
  final double relevance;
  final String description;

  RecommendedContent({
    required this.id,
    required this.type,
    required this.title,
    required this.relevance,
    required this.description,
  });
}
