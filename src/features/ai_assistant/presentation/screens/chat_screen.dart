import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/providers/ai_assistant_providers.dart';
import 'package:blvl_17_04_tmp/src/domain/models/chat_message.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/typing_indicator.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(currentChatSessionProvider);
    if (sessionId == null) {
      return const Scaffold(body: Center(child: Text('Сессия не выбрана')));
    }
    final messagesAsync = ref.watch(chatHistoryProvider(sessionId));
    return Scaffold(
      appBar: AppBar(title: const Text('Чат с Лео')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messagesAsync.when(
                data:
                    (messages) => ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[messages.length - 1 - index];
                        return MessageBubble(message: msg);
                      },
                    ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Ошибка: $e')),
              ),
            ),
            const TypingIndicator(), // TODO: показывать только если ассистент "печатает"
            const ChatInputField(),
          ],
        ),
      ),
    );
  }
}
