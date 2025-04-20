import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/ai_assistant_service.dart';
import '../services/ai_assistant_service_impl.dart';
import '../services/context_builder.dart';
import '../services/chat_session_manager.dart';
import '../services/ai_response_processor.dart';
import '../services/personalization_engine.dart';

final aiAssistantServiceProvider = Provider<IAIAssistantService>((ref) {
  return AIAssistantService(
    contextBuilder: ContextBuilder(),
    sessionManager: ChatSessionManager(),
    responseProcessor: AIResponseProcessor(),
    personalizationEngine: PersonalizationEngine(),
  );
});

final currentChatSessionProvider = StateProvider<String?>((ref) => null);

final chatHistoryProvider = StreamProvider.family.autoDispose((
  ref,
  String sessionId,
) {
  final service = ref.watch(aiAssistantServiceProvider);
  return service.getMessages(sessionId);
});

final messageSendStateProvider = StateProvider<AsyncValue<void>>(
  (ref) => const AsyncValue.data(null),
);
