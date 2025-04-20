import 'package:flutter/material.dart';

class UserStatsOverview extends StatelessWidget {
  final dynamic stats;
  const UserStatsOverview({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stats == null) return SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(label: 'Уровень', value: '${stats.currentLevel ?? '-'}'),
            _StatItem(
              label: 'Видео',
              value: '${stats.totalVideosWatched ?? '-'}',
            ),
            _StatItem(
              label: 'Тесты',
              value: '${stats.totalTestsCompleted ?? '-'}',
            ),
            _StatItem(
              label: 'Артефакты',
              value: '${stats.totalArtifactsDownloaded ?? '-'}',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
