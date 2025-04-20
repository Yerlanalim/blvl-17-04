import 'package:flutter/material.dart';
import '../../../../domain/models/subscription.dart';

class SubscriptionInfoCard extends StatelessWidget {
  final Subscription subscription;
  const SubscriptionInfoCard({Key? key, required this.subscription})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать карточку информации о подписке
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'План: ${subscription.planId}\nСтатус: ${subscription.status.name}',
        ),
      ),
    );
  }
}
