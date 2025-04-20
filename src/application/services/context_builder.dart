import '../../../lib/src/domain/models/user_profile.dart';
import '../../domain/models/chat_message.dart';

/// Класс для формирования релевантного контекста для ИИ-ассистента
class ContextBuilder {
  /// Формирует контекст для запроса к ИИ на основе истории сообщений и профиля пользователя
  Future<String> buildContext({
    required List<ChatMessage> messages,
    required UserProfile userProfile,
    int maxTokens = 2048,
  }) async {
    // TODO: реализовать оптимизацию размера контекста и персонализацию
    // Пример: собрать последние N сообщений, добавить системные инструкции, инфо о навыках
    final contextBuffer = StringBuffer();
    contextBuffer.writeln('Пользователь: ${userProfile.displayName}');
    contextBuffer.writeln('Навыки: ${userProfile.skills}');
    for (final msg in messages.takeLast(10)) {
      contextBuffer.writeln('[${msg.sender.name}] ${msg.content}');
    }
    return contextBuffer.toString();
  }
}

extension<T> on List<T> {
  List<T> takeLast(int n) => length <= n ? this : sublist(length - n);
}
