import 'package:flutter/material.dart';

class SubscriptionConfirmationDialog extends StatelessWidget {
  const SubscriptionConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать диалог подтверждения подписки
    return AlertDialog(
      title: const Text('Подтвердите подписку'),
      content: const Text('Вы уверены, что хотите оформить подписку?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
