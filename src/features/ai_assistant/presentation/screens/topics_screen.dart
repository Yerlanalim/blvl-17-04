import 'package:flutter/material.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать экран топиков
    return Scaffold(
      appBar: AppBar(title: const Text('Топики чата')),
      body: const Center(child: Text('Здесь будут топики чата')),
    );
  }
}
