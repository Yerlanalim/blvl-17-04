import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownMessageContent extends StatelessWidget {
  final String text;
  const MarkdownMessageContent({Key? key, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        code: const TextStyle(
          fontFamily: 'monospace',
          backgroundColor: Color(0xFFF5F5F5),
        ),
      ),
      onTapLink: (text, href, title) {
        if (href != null) {
          // TODO: реализовать предпросмотр ссылки или переход
        }
      },
    );
  }
}
