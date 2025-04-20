import '../../domain/services/ai_assistant_service.dart';
import '../../domain/models/chat_session.dart';
import '../../domain/models/chat_message.dart';
import '../../../lib/src/domain/models/user_profile.dart';
import 'context_builder.dart';
import 'chat_session_manager.dart';
import 'ai_response_processor.dart';
import 'personalization_engine.dart';

/// Реализация сервиса ИИ-ассистента для управления диалогами, сессиями и персонализацией
class AIAssistantService implements IAIAssistantService {
  final ContextBuilder contextBuilder;
  final ChatSessionManager sessionManager;
  final AIResponseProcessor responseProcessor;
  final PersonalizationEngine personalizationEngine;
  // TODO: добавить зависимости для Firestore, Cloud Functions, ProgressManager

  // Для примера userId можно получать из auth или передавать явно
  String? userId;

  AIAssistantService({
    required this.contextBuilder,
    required this.sessionManager,
    required this.responseProcessor,
    required this.personalizationEngine,
    this.userId,
  });

  /// Создает новую сессию чата
  @override
  Future<ChatSession> createSession({String? title}) async {
    if (userId == null) throw Exception('userId is required');
    return await sessionManager.createSession(userId: userId!, title: title);
  }

  /// Отправляет сообщение в сессию и получает ответ ИИ
  @override
  Future<ChatMessage> sendMessage(String sessionId, String message) async {
    if (userId == null) throw Exception('userId is required');
    final firestore = sessionManager.firestore;
    final messagesRef = firestore
        .collection('chats')
        .doc(userId)
        .collection('sessions')
        .doc(sessionId)
        .collection('messages');
    final now = DateTime.now();
    // 1. Сохраняем сообщение пользователя
    final userMsg = ChatMessage(
      id: messagesRef.doc().id,
      sessionId: sessionId,
      sender: ChatSender.user,
      content: message,
      timestamp: now,
      meta: {},
    );
    await messagesRef.doc(userMsg.id).set(userMsg.toMap());

    // 2. Получаем последние сообщения для контекста
    final historySnap =
        await messagesRef
            .orderBy('timestamp', descending: true)
            .limit(20)
            .get();
    final history =
        historySnap.docs
            .map((doc) => ChatMessage.fromMap(doc.data()))
            .toList()
            .reversed
            .toList();

    // 3. Получаем профиль пользователя (заглушка, можно внедрить через провайдер)
    final userProfile = UserProfile(
      displayName: 'Пользователь',
      photoUrl: null,
      businessInfo: null,
      skills: {},
      achievements: [],
    );

    // 4. Формируем контекст
    final context = await contextBuilder.buildContext(
      messages: history,
      userProfile: userProfile,
    );

    // 5. Вызываем Cloud Function (заглушка)
    // TODO: заменить на реальный вызов через cloud_functions
    final aiRawResponse = await _mockGeminiApi(context, message);

    // 6. Обрабатываем и персонализируем ответ
    var aiMsg = responseProcessor.processAIResponse(
      rawResponse: aiRawResponse,
      sessionId: sessionId,
    );
    aiMsg = ChatMessage(
      id: aiMsg.id,
      sessionId: aiMsg.sessionId,
      sender: aiMsg.sender,
      content: personalizationEngine.personalize(
        aiResponse: aiMsg.content,
        userProfile: userProfile,
        history: history,
      ),
      timestamp: aiMsg.timestamp,
      meta: aiMsg.meta,
    );

    // 7. Сохраняем ответ ИИ
    await messagesRef.doc(aiMsg.id).set(aiMsg.toMap());
    return aiMsg;
  }

  Future<String> _mockGeminiApi(String context, String message) async {
    // TODO: заменить на реальный вызов Cloud Function
    await Future.delayed(const Duration(seconds: 1));
    return 'Это ответ ИИ на: "$message"';
  }

  /// Получает поток истории сообщений для сессии
  @override
  Stream<List<ChatMessage>> getMessages(String sessionId) {
    if (userId == null) throw Exception('userId is required');
    final firestore = sessionManager.firestore;
    return firestore
        .collection('chats')
        .doc(userId)
        .collection('sessions')
        .doc(sessionId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatMessage.fromMap(doc.data()))
                  .toList(),
        );
  }

  /// Удаляет сессию чата
  @override
  Future<void> deleteSession(String sessionId) async {
    if (userId == null) throw Exception('userId is required');
    await sessionManager.deleteSession(userId!, sessionId);
  }

  /// Получает список всех сессий пользователя
  @override
  Future<List<ChatSession>> getSessions() async {
    if (userId == null) throw Exception('userId is required');
    return await sessionManager.getSessions(userId!);
  }

  /// Персонализирует сессию на основе профиля пользователя
  @override
  Future<void> personalizeSession(String sessionId, UserProfile profile) async {
    // Можно обновить метаданные сессии (например, добавить уровень, навыки)
    // Для простоты — TODO: реализовать обновление в Firestore
    // await firestore.collection('chats').doc(userId).collection('sessions').doc(sessionId).update({'profile': profile.toMap()});
    // Пока заглушка:
    return;
  }

  /// Получает подсказки для текущей сессии
  @override
  Future<List<String>> getHints(String sessionId) async {
    // TODO: реализовать через Cloud Function или локально
    return [
      'Попробуйте задать вопрос по теме текущего уровня.',
      'Вы можете попросить объяснить сложный термин.',
    ];
  }

  /// Получает рекомендации по обучению для текущей сессии
  @override
  Future<List<String>> getRecommendations(String sessionId) async {
    // TODO: реализовать через Cloud Function или на основе прогресса пользователя
    return [
      'Рекомендуем пройти тест по текущему уровню.',
      'Посмотрите дополнительное видео для углубления знаний.',
    ];
  }
}
