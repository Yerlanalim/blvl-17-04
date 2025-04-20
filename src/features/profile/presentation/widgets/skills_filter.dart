import 'package:flutter/material.dart';

class SkillsFilter extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  const SkillsFilter({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: 'Все',
          items: [
            DropdownMenuItem(value: 'Все', child: Text('Все')),
            DropdownMenuItem(value: 'Личные', child: Text('Личные')),
            DropdownMenuItem(value: 'Менеджмент', child: Text('Менеджмент')),
            // TODO: добавить другие категории
          ],
          onChanged: onChanged,
        ),
        // TODO: добавить сортировку
      ],
    );
  }
}
