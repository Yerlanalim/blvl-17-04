import 'package:flutter/material.dart';

class SkillsBarChart extends StatelessWidget {
  final Map<String, int> skills;
  final void Function(String, int)? onSkillTap;
  const SkillsBarChart({Key? key, required this.skills, this.onSkillTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skillNames = skills.keys.toList();
    return ListView.separated(
      itemCount: skillNames.length,
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemBuilder: (context, i) {
        return InkWell(
          onTap:
              onSkillTap != null
                  ? () => onSkillTap!(skillNames[i], skills[skillNames[i]] ?? 0)
                  : null,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  skillNames[i],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: (skills[skillNames[i]] ?? 0) / 100,
                ),
              ),
              SizedBox(width: 12),
              Text(
                '${skills[skillNames[i]]}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}
