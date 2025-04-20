import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/subscription_info_card.dart';
import '../widgets/subscription_status_badge.dart';
import '../widgets/subscription_timer.dart';
import '../widgets/benefits_list.dart';
import '../widgets/subscription_cancellation_dialog.dart';
import '../providers/subscription_ui_providers.dart';

class SubscriptionDetailsScreen extends ConsumerWidget {
  const SubscriptionDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Получить userId из провайдера пользователя
    final userId = 'demo_user';
    final statusAsync = ref.watch(subscriptionStatusUiProvider(userId));
    final historyAsync = ref.watch(subscriptionHistoryUiProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Детали подписки')),
      body: statusAsync.when(
        data:
            (status) => historyAsync.when(
              data:
                  (history) => _DetailsContent(
                    status: status,
                    // предполагаем, что history[0] — текущая активная подписка
                    subscription: history.isNotEmpty ? history[0] : null,
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Ошибка истории: $e')),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка статуса: $e')),
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  final dynamic status;
  final dynamic subscription;
  const _DetailsContent({required this.status, required this.subscription});

  @override
  Widget build(BuildContext context) {
    if (subscription == null) {
      return const Center(child: Text('Нет активной подписки'));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SubscriptionInfoCard(subscription: subscription),
        const SizedBox(height: 12),
        SubscriptionStatusBadge(status: status),
        const SizedBox(height: 12),
        SubscriptionTimer(endDate: subscription.endDate),
        const SizedBox(height: 24),
        const BenefitsList(),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (ctx) => const SubscriptionCancellationDialog(),
            );
            if (confirmed == true) {
              // TODO: Вызвать отмену подписки через провайдер/сервис
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Подписка отменена')),
              );
            }
          },
          child: const Text('Отменить подписку'),
        ),
      ],
    );
  }
}
