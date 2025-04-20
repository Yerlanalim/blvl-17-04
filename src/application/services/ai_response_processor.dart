import '../../domain/models/chat_message.dart';

/// Класс для обработки и форматирования ответов ИИ-ассистента
class AIResponseProcessor {
  /// Обрабатывает и форматирует ответ ИИ
  ChatMessage processAIResponse({
    required String rawResponse,
    required String sessionId,
  }) {
    // TODO: реализовать фильтрацию, форматирование, извлечение рекомендаций
    return ChatMessage(
      id: UniqueKey().toString(),
      sessionId: sessionId,
      sender: ChatSender.ai,
      content: rawResponse.trim(),
      timestamp: DateTime.now(),
      meta: {},
    );
  }
}

/// Вспомогательный класс для генерации уникальных id сообщений
class UniqueKey {
  static int _counter = 0;
  final int value;
  UniqueKey() : value = _counter++;
  @override
  String toString() => 'ai_msg_$value';
}
