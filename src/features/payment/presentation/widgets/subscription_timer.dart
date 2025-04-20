import 'package:flutter/material.dart';

class SubscriptionTimer extends StatelessWidget {
  final DateTime endDate;
  const SubscriptionTimer({Key? key, required this.endDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final remaining = endDate.difference(now);
    final text =
        remaining.isNegative
            ? 'Подписка истекла'
            : 'Осталось: ${remaining.inDays} дн. ${(remaining.inHours % 24).toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}';
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
  }
}
