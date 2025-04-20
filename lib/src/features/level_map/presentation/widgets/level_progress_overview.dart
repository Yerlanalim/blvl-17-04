import 'package:flutter/material.dart';
import '../../../../application/models/level_map_view_model.dart';

class LevelProgressOverview extends StatelessWidget {
  final LevelMapViewModel map;
  final double overallProgress;

  const LevelProgressOverview({
    Key? key,
    required this.map,
    required this.overallProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completed =
        map.nodes
            .where(
              (n) =>
                  n.status == LevelStatus.available &&
                  n.level.completedAt != null,
            )
            .length;
    final total = map.nodes.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Прогресс: ${(overallProgress * 100).toStringAsFixed(0)}% ($completed из $total уровней)',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: overallProgress,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}
