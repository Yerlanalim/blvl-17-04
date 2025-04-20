import 'package:flutter/material.dart';
import 'level_status_indicator.dart';

class LevelMapLegend extends StatelessWidget {
  const LevelMapLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _LegendItem(label: 'Доступен', status: LevelStatus.available),
            _LegendItem(label: 'Завершён', status: LevelStatus.completed),
            _LegendItem(label: 'Заблокирован', status: LevelStatus.locked),
            _LegendItem(label: 'Премиум', status: LevelStatus.premium),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final LevelStatus status;

  const _LegendItem({Key? key, required this.label, required this.status})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LevelStatusIndicator(status: status),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
