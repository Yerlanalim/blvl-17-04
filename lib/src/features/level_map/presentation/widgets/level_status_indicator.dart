import 'package:flutter/material.dart';

enum LevelStatus { available, completed, locked, premium }

class LevelStatusIndicator extends StatelessWidget {
  final LevelStatus status;

  const LevelStatusIndicator({Key? key, required this.status})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    switch (status) {
      case LevelStatus.completed:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case LevelStatus.available:
        icon = Icons.radio_button_checked;
        color = Colors.blueAccent;
        break;
      case LevelStatus.locked:
        icon = Icons.lock;
        color = Colors.grey;
        break;
      case LevelStatus.premium:
        icon = Icons.star;
        color = Colors.amber;
        break;
    }
    return Semantics(
      label: _statusLabel(status),
      child: Icon(icon, color: color, size: 24),
    );
  }

  String _statusLabel(LevelStatus status) {
    switch (status) {
      case LevelStatus.completed:
        return 'Завершённый уровень';
      case LevelStatus.available:
        return 'Доступный уровень';
      case LevelStatus.locked:
        return 'Заблокированный уровень';
      case LevelStatus.premium:
        return 'Премиум уровень';
    }
  }
}
