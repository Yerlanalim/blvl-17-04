import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/payment_history_item.dart';
import '../providers/subscription_ui_providers.dart';
import '../../../../domain/models/payment_record.dart';

class PaymentHistoryScreen extends ConsumerWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = 'demo_user'; // TODO: заменить на реального пользователя
    final historyAsync = ref.watch(paymentHistoryUiProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('История платежей')),
      body: historyAsync.when(
        data: (history) {
          final records =
              (history as List)
                  .where((e) => e is PaymentRecord)
                  .cast<PaymentRecord>()
                  .toList();
          if (records.isEmpty) {
            return const Center(child: Text('Нет платежей'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: records.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) => PaymentHistoryItem(record: records[i]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}
