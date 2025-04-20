import 'package:flutter/material.dart';

class AchievementsSection extends StatelessWidget {
  final List achievements;
  const AchievementsSection({Key? key, required this.achievements})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Достижения не найдены',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Достижения',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        // TODO: добавить AchievementsFilter
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AchievementCard(achievement: achievement),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AchievementCard extends StatelessWidget {
  final dynamic achievement;
  const AchievementCard({Key? key, required this.achievement})
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
            Icon(Icons.emoji_events, size: 32), // TODO: иконка достижения
            SizedBox(height: 8),
            Text(
              achievement.title ?? 'Достижение',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8),
            Text(
              achievement.description ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
