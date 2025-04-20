import '../../domain/models/chat_message.dart';

/// Класс для оптимизации контекста диалога (сжатие, приоритизация, управление токенами)
class ContextOptimizer {
  final int maxTokens;
  final int maxMessages;

  ContextOptimizer({this.maxTokens = 2048, this.maxMessages = 20});

  /// Оставляет только наиболее релевантные сообщения для контекста
  List<ChatMessage> optimize(List<ChatMessage> history, {String? topic}) {
    // TODO: Можно добавить приоритизацию по теме, времени, важности
    final sorted = List<ChatMessage>.from(history)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(maxMessages).toList();
  }

  /// Сжимает историю до лимита токенов (заглушка, можно заменить на реальный подсчет)
  List<ChatMessage> compressToTokenLimit(List<ChatMessage> history) {
    int tokens = 0;
    final result = <ChatMessage>[];
    for (final msg in history.reversed) {
      final msgTokens = _estimateTokens(msg.content);
      if (tokens + msgTokens > maxTokens) break;
      tokens += msgTokens;
      result.insert(0, msg);
    }
    return result;
  }

  /// Оценка количества токенов в сообщении (заглушка)
  int _estimateTokens(String text) => (text.length / 4).ceil();
}
