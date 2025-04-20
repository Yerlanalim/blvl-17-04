import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_message.dart';

/// Модель сессии чата ИИ-ассистента
class ChatSession {
  /// Уникальный идентификатор сессии
  final String id;

  /// Название сессии (может быть задано пользователем)
  final String title;

  /// Идентификатор пользователя
  final String userId;

  /// Дата и время создания
  final DateTime createdAt;

  /// Активна ли сессия
  final bool isActive;

  /// История сообщений в сессии
  final List<ChatMessage> messages;

  ChatSession({
    required this.id,
    required this.title,
    required this.userId,
    required this.createdAt,
    required this.isActive,
    required this.messages,
  });

  factory ChatSession.fromMap(Map<String, dynamic> map, String id) {
    return ChatSession(
      id: id,
      title: map['title'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isActive: map['isActive'] ?? true,
      messages:
          (map['messages'] as List<dynamic>? ?? [])
              .map((m) => ChatMessage.fromMap(m as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'isActive': isActive,
      'messages': messages.map((m) => m.toMap()).toList(),
    };
  }
}
