import 'package:flutter/material.dart';

class SubscriptionUpsellDialog extends StatelessWidget {
  final VoidCallback? onSubscribe;
  const SubscriptionUpsellDialog({Key? key, this.onSubscribe})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Доступ к премиум-контенту'),
      content: const Text(
        'Оформите подписку, чтобы получить доступ к эксклюзивным материалам и возможностям.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: onSubscribe,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
          ),
          child: const Text('Оформить подписку'),
        ),
      ],
    );
  }
}
