import '../models/chat_session.dart';
import '../models/chat_message.dart';
import '../../../lib/src/domain/models/user_profile.dart';

/// Интерфейс сервиса ИИ-ассистента для управления диалогами, сессиями и персонализацией
abstract class IAIAssistantService {
  /// Создает новую сессию чата
  Future<ChatSession> createSession({String? title});

  /// Отправляет сообщение в сессию и получает ответ ИИ
  Future<ChatMessage> sendMessage(String sessionId, String message);

  /// Получает поток истории сообщений для сессии
  Stream<List<ChatMessage>> getMessages(String sessionId);

  /// Удаляет сессию чата
  Future<void> deleteSession(String sessionId);

  /// Получает список всех сессий пользователя
  Future<List<ChatSession>> getSessions();

  /// Персонализирует сессию на основе профиля пользователя
  Future<void> personalizeSession(String sessionId, UserProfile profile);

  /// Получает подсказки для текущей сессии
  Future<List<String>> getHints(String sessionId);

  /// Получает рекомендации по обучению для текущей сессии
  Future<List<String>> getRecommendations(String sessionId);
}
