import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String? selectedMethod;
  final ValueChanged<String> onMethodSelected;
  const PaymentMethodSelector({
    Key? key,
    this.selectedMethod,
    required this.onMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать выбор способа оплаты
    return DropdownButton<String>(
      value: selectedMethod,
      hint: const Text('Выберите способ оплаты'),
      items: const [
        DropdownMenuItem(value: 'card', child: Text('Банковская карта')),
        DropdownMenuItem(value: 'kaspi', child: Text('Kaspi.kz')),
        DropdownMenuItem(value: 'applepay', child: Text('Apple Pay')),
      ],
      onChanged: (value) {
        if (value != null) onMethodSelected(value);
      },
    );
  }
}
