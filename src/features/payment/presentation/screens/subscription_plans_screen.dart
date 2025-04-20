import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/subscription_plan_card.dart';
import '../widgets/subscription_comparison.dart';
import '../widgets/subscription_cta.dart';
import '../providers/subscription_ui_providers.dart';
import '../../../../domain/models/subscription_plan.dart';

class SubscriptionPlansScreen extends ConsumerWidget {
  const SubscriptionPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(subscriptionPlansUiProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Планы подписки')),
      body: plansAsync.when(
        data: (plans) => _PlansList(plans: plans as List<SubscriptionPlan>),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка загрузки: $e')),
      ),
    );
  }
}

class _PlansList extends StatelessWidget {
  final List<SubscriptionPlan> plans;
  const _PlansList({required this.plans});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...plans.map(
          (plan) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SubscriptionPlanCard(plan: plan),
          ),
        ),
        const SizedBox(height: 24),
        const SubscriptionComparison(),
        const SizedBox(height: 24),
        const SubscriptionCTA(),
      ],
    );
  }
}
