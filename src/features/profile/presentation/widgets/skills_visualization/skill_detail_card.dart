import 'package:flutter/material.dart';

class SkillDetailCard extends StatelessWidget {
  final String skillName;
  final int skillValue;
  const SkillDetailCard({
    Key? key,
    required this.skillName,
    required this.skillValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(skillName, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 12),
            LinearProgressIndicator(value: skillValue / 100),
            SizedBox(height: 8),
            Text(
              'Уровень: $skillValue',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Связанные навыки: ...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 8),
            Text(
              'Рекомендации: ...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
