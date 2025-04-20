import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blvl_17_04_tmp/src/domain/models/chat_message.dart';
import 'markdown_message_content.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const MessageBubble({Key? key, required this.message}) : super(key: key);

  bool get isUser => message.sender == ChatSender.user;
  bool get isAI => message.sender == ChatSender.ai;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bubbleColor =
        isUser
            ? theme.colorScheme.primary.withOpacity(0.12)
            : theme.colorScheme.surfaceVariant;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
      bottomRight:
          isUser ? const Radius.circular(4) : const Radius.circular(16),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        crossAxisAlignment: align,
        children: [
          GestureDetector(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: message.content));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Текст скопирован')));
            },
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: radius,
              ),
              child: MarkdownMessageContent(text: message.content),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _formatTime(message.timestamp),
            style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
