import 'package:flutter/material.dart';

class AISettingsScreen extends StatelessWidget {
  const AISettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать настройки AI
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки AI')),
      body: const Center(child: Text('Здесь будут настройки AI')),
    );
  }
}
