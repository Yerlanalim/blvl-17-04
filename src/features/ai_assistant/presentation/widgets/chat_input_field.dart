import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/providers/ai_assistant_providers.dart';

class ChatInputField extends ConsumerStatefulWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends ConsumerState<ChatInputField> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.watch(currentChatSessionProvider);
    final sendState = ref.watch(messageSendStateProvider);
    final isSending = sendState.isLoading || _sending;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !isSending,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Введите сообщение...',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon:
                isSending
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.send),
            onPressed: isSending ? null : _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    final sessionId = ref.read(currentChatSessionProvider);
    if (text.isEmpty || sessionId == null) return;
    setState(() => _sending = true);
    final service = ref.read(aiAssistantServiceProvider);
    try {
      await service.sendMessage(sessionId, text);
      _controller.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка отправки: $e')));
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
