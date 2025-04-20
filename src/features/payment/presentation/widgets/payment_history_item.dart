import 'package:flutter/material.dart';
import '../../../../domain/models/payment_record.dart';

class PaymentHistoryItem extends StatelessWidget {
  final PaymentRecord record;
  const PaymentHistoryItem({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать элемент истории платежей
    return ListTile(
      title: Text('Сумма: ${record.amount} (${record.status.name})'),
      subtitle: Text(
        'Дата: ${record.date.toLocal()}\nМетод: ${record.paymentMethod}',
      ),
    );
  }
}
