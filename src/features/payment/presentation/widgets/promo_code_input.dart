import 'package:flutter/material.dart';

class PromoCodeInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const PromoCodeInput({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать ввод промо-кода
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Промо-код',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
