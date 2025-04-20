import 'package:flutter/material.dart';

class SubscriptionSuccessScreen extends StatelessWidget {
  const SubscriptionSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Подписка оформлена')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.celebration, color: Colors.amber, size: 80),
            const SizedBox(height: 24),
            Text(
              'Поздравляем!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            const Text(
              'Ваша подписка успешно активирована.\nСпасибо, что выбрали нас!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushReplacementNamed('/subscription-details');
              },
              child: const Text('Перейти к подписке'),
            ),
          ],
        ),
      ),
    );
  }
}
