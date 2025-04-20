import 'package:flutter/material.dart';

class PremiumContentBadge extends StatelessWidget {
  const PremiumContentBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать бейдж премиум-контента
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text('Premium'),
    );
  }
}
