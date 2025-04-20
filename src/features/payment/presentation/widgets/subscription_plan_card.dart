import 'package:flutter/material.dart';
import '../../../../domain/models/subscription_plan.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  const SubscriptionPlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать карточку плана подписки
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(plan.name),
      ),
    );
  }
}
