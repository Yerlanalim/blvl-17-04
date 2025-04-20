import 'package:cloud_firestore/cloud_firestore.dart';

/// Отправитель сообщения в чате
enum ChatSender { user, ai, system }

/// Модель сообщения в чате ИИ-ассистента
class ChatMessage {
  /// Уникальный идентификатор сообщения
  final String id;

  /// Идентификатор сессии чата
  final String sessionId;

  /// Отправитель (пользователь, ИИ, система)
  final ChatSender sender;

  /// Текст сообщения
  final String content;

  /// Время отправки
  final DateTime timestamp;

  /// Дополнительные метаданные (например, рекомендации)
  final Map<String, dynamic>? meta;

  ChatMessage({
    required this.id,
    required this.sessionId,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.meta,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      sessionId: map['sessionId'] ?? '',
      sender: ChatSender.values.firstWhere(
        (e) => e.toString() == 'ChatSender.${map['sender']}',
        orElse: () => ChatSender.system,
      ),
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      meta: map['meta'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sessionId': sessionId,
      'sender': sender.name,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'meta': meta,
    };
  }
}
