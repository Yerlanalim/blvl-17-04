import 'package:flutter/material.dart';

class PremiumContentLock extends StatelessWidget {
  final String? message;
  final VoidCallback? onUnlockTap;
  const PremiumContentLock({Key? key, this.message, this.onUnlockTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock, color: Colors.amber, size: 48),
            const SizedBox(height: 12),
            Text(
              message ?? 'Премиум-контент доступен по подписке',
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onUnlockTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
              ),
              child: const Text('Оформить подписку'),
            ),
          ],
        ),
      ),
    );
  }
}
