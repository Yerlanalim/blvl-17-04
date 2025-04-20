import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final Map<String, int> skills;
  const SkillsSection({Key? key, required this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Навыки не найдены',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('Навыки', style: Theme.of(context).textTheme.titleMedium),
        ),
        // TODO: добавить SkillsFilter
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skillName = skills.keys.elementAt(index);
              final skillValue = skills[skillName] ?? 0;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SkillListItem(name: skillName, value: skillValue),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SkillListItem extends StatelessWidget {
  final String name;
  final int value;
  const SkillListItem({Key? key, required this.name, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 32), // TODO: иконка навыка
            SizedBox(height: 8),
            Text(name, style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            SkillProgressBar(
              progress: value / 100,
            ), // TODO: нормализовать по максимуму
          ],
        ),
      ),
    );
  }
}

class SkillProgressBar extends StatelessWidget {
  final double progress;
  const SkillProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: progress);
  }
}
