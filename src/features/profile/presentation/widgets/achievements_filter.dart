import 'package:flutter/material.dart';

class AchievementsFilter extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  const AchievementsFilter({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: 'Все',
          items: [
            DropdownMenuItem(value: 'Все', child: Text('Все')),
            DropdownMenuItem(value: 'Открытые', child: Text('Открытые')),
            DropdownMenuItem(value: 'Скрытые', child: Text('Скрытые')),
            // TODO: добавить другие категории
          ],
          onChanged: onChanged,
        ),
        // TODO: добавить сортировку
      ],
    );
  }
}
