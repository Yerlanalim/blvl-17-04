import 'package:flutter/material.dart';

class SkillsGridView extends StatelessWidget {
  final Map<String, int> skills;
  final void Function(String, int)? onSkillTap;
  const SkillsGridView({Key? key, required this.skills, this.onSkillTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skillNames = skills.keys.toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: skillNames.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap:
              onSkillTap != null
                  ? () => onSkillTap!(skillNames[i], skills[skillNames[i]] ?? 0)
                  : null,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 28),
                  SizedBox(height: 8),
                  Text(
                    skillNames[i],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (skills[skillNames[i]] ?? 0) / 100,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${skills[skillNames[i]]}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
