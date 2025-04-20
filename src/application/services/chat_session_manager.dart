import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/chat_session.dart';
import '../../domain/models/chat_message.dart';

/// Класс для управления сессиями чата ИИ-ассистента (создание, удаление, восстановление, оффлайн-режим)
class ChatSessionManager {
  final FirebaseFirestore firestore;

  ChatSessionManager({FirebaseFirestore? firestore})
    : firestore = firestore ?? FirebaseFirestore.instance;

  /// Создает новую сессию чата для пользователя
  Future<ChatSession> createSession({
    required String userId,
    String? title,
  }) async {
    final sessionRef =
        firestore.collection('chats').doc(userId).collection('sessions').doc();
    final now = DateTime.now();
    final session = ChatSession(
      id: sessionRef.id,
      title: title ?? 'Новая сессия',
      userId: userId,
      createdAt: now,
      isActive: true,
      messages: [],
    );
    await sessionRef.set(session.toMap());
    return session;
  }

  /// Удаляет сессию чата по идентификатору
  Future<void> deleteSession(String userId, String sessionId) async {
    final sessionRef = firestore
        .collection('chats')
        .doc(userId)
        .collection('sessions')
        .doc(sessionId);
    await sessionRef.delete();
  }

  /// Получает список всех сессий пользователя
  Future<List<ChatSession>> getSessions(String userId) async {
    final query =
        await firestore
            .collection('chats')
            .doc(userId)
            .collection('sessions')
            .orderBy('createdAt', descending: true)
            .get();
    return query.docs
        .map((doc) => ChatSession.fromMap(doc.data(), doc.id))
        .toList();
  }

  /// Восстанавливает последнюю сессию пользователя (локально/онлайн)
  Future<ChatSession?> restoreLastSession(String userId) async {
    final query =
        await firestore
            .collection('chats')
            .doc(userId)
            .collection('sessions')
            .orderBy('createdAt', descending: true)
            .limit(1)
            .get();
    if (query.docs.isEmpty) return null;
    final doc = query.docs.first;
    return ChatSession.fromMap(doc.data(), doc.id);
  }
}
