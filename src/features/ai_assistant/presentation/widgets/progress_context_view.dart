import 'package:flutter/material.dart';

class ProgressContextView extends StatelessWidget {
  final String currentLevel;
  final int completedLevels;
  final int totalVideosWatched;
  final int totalTestsCompleted;

  const ProgressContextView({
    Key? key,
    required this.currentLevel,
    required this.completedLevels,
    required this.totalVideosWatched,
    required this.totalTestsCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Текущий уровень: $currentLevel',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text('Пройдено уровней: $completedLevels'),
            Text('Просмотрено видео: $totalVideosWatched'),
            Text('Пройдено тестов: $totalTestsCompleted'),
          ],
        ),
      ),
    );
  }
}
