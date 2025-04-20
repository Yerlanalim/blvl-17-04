import 'package:flutter/material.dart';

class SubscriptionCancellationDialog extends StatelessWidget {
  const SubscriptionCancellationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать диалог отмены подписки
    return AlertDialog(
      title: const Text('Отмена подписки'),
      content: const Text('Вы уверены, что хотите отменить подписку?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Нет'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Да, отменить'),
        ),
      ],
    );
  }
}
