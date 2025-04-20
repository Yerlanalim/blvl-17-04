import 'package:flutter/material.dart';

class ChatStatsScreen extends StatelessWidget {
  const ChatStatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать статистику чата
    return Scaffold(
      appBar: AppBar(title: const Text('Статистика чата')),
      body: const Center(child: Text('Здесь будет статистика чата')),
    );
  }
}
