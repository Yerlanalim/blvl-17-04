import '../../domain/models/chat_message.dart';

abstract class ContextPrioritizationStrategy {
  List<ChatMessage> prioritize(List<ChatMessage> history, {String? topic});
}

/// Приоритизация по времени (последние сообщения)
class TimeBasedPrioritization implements ContextPrioritizationStrategy {
  final int maxMessages;
  TimeBasedPrioritization({this.maxMessages = 20});
  @override
  List<ChatMessage> prioritize(List<ChatMessage> history, {String? topic}) {
    final sorted = List<ChatMessage>.from(history)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(maxMessages).toList();
  }
}

/// Приоритизация по теме (заглушка)
class TopicBasedPrioritization implements ContextPrioritizationStrategy {
  final String topic;
  final int maxMessages;
  TopicBasedPrioritization(this.topic, {this.maxMessages = 20});
  @override
  List<ChatMessage> prioritize(List<ChatMessage> history, {String? topic}) {
    // TODO: реализовать фильтрацию по теме
    return history
        .where((m) => m.content.contains(this.topic))
        .take(maxMessages)
        .toList();
  }
}
