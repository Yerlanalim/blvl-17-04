import 'package:flutter/material.dart';

class SkillsTreeView extends StatelessWidget {
  final Map<String, int> skills;
  final void Function(String, int)? onSkillTap;
  const SkillsTreeView({Key? key, required this.skills, this.onSkillTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skillNames = skills.keys.toList();
    return ListView.separated(
      itemCount: skillNames.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, i) {
        return InkWell(
          onTap:
              onSkillTap != null
                  ? () => onSkillTap!(skillNames[i], skills[skillNames[i]] ?? 0)
                  : null,
          child: Padding(
            padding: EdgeInsets.only(
              left: (i % 3) * 16.0,
              right: 8,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                Icon(Icons.circle, size: 16),
                SizedBox(width: 8),
                Text(
                  skillNames[i],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacer(),
                Text(
                  '${skills[skillNames[i]]}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
