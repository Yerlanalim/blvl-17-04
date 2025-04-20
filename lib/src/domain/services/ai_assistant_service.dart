/// Интерфейс сервиса ИИ-ассистента (например, Gemini API)
abstract class AIAssistantService {
  /// Отправить сообщение ассистенту и получить ответ
  Future<String> sendMessage(
    String userId,
    String message, {
    Map<String, dynamic>? context,
  });

  /// Получить историю чата пользователя
  Future<List<Map<String, dynamic>>> getChatHistory(String userId);
}
