import 'package:flutter/material.dart';

/// Виджет для отображения баллов за тест
class ScoreDisplay extends StatelessWidget {
  final int score;
  final int maxScore;

  const ScoreDisplay({super.key, required this.score, required this.maxScore});

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для отображения баллов
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Баллы: '), Text('$score / $maxScore')],
    );
  }
}
