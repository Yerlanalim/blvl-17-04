import '../../../lib/src/domain/models/user_profile.dart';
import '../../domain/models/chat_message.dart';

/// Класс для персонализации ответов ИИ-ассистента под пользователя
class PersonalizationEngine {
  /// Персонализирует ответ ИИ на основе профиля пользователя и истории
  String personalize({
    required String aiResponse,
    required UserProfile userProfile,
    List<ChatMessage>? history,
  }) {
    // TODO: реализовать персонализацию по уровню, навыкам, предпочтениям
    // Пример: добавить обращение по имени, адаптировать стиль
    return '${userProfile.displayName}, ${aiResponse.trim()}';
  }
}
