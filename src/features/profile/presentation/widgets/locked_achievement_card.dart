import 'package:flutter/material.dart';

class LockedAchievementCard extends StatelessWidget {
  const LockedAchievementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 32, color: Colors.grey[600]),
            SizedBox(height: 8),
            Text('???', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            Text(
              'Скрытое достижение',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
