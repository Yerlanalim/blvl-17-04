import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/promo_code_input.dart';
import '../widgets/payment_form.dart';
import '../widgets/payment_status_indicator.dart';
import '../providers/subscription_ui_providers.dart';
import '../../../../application/providers/payment_providers.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(subscriptionScreenControllerProvider);
    final paymentProcess = ref.watch(paymentProcessProvider);
    final paymentProcessNotifier = ref.read(paymentProcessProvider.notifier);
    final userId = 'demo_user'; // TODO: заменить на реального пользователя

    // Если не выбран план — возвращаемся на экран планов
    if (controller.selectedPlan == null) {
      Future.microtask(() => Navigator.of(context).pop());
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Оплата')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'План: ${controller.selectedPlan!.name}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            PaymentMethodSelector(
              selectedMethod: controller.selectedPaymentMethod,
              onMethodSelected:
                  (method) => ref
                      .read(subscriptionScreenControllerProvider.notifier)
                      .selectPaymentMethod(method),
            ),
            const SizedBox(height: 16),
            PromoCodeInput(
              onChanged:
                  (code) => ref
                      .read(subscriptionScreenControllerProvider.notifier)
                      .setPromoCode(code),
            ),
            const SizedBox(height: 16),
            PaymentForm(
              plan: controller.selectedPlan!,
              paymentMethodType: controller.selectedPaymentMethod,
              promoCode: controller.promoCode,
              userId: userId,
              onSubmit: (paymentRequest) async {
                await paymentProcessNotifier.startPayment(paymentRequest);
              },
              isProcessing: paymentProcess.isLoading,
            ),
            const SizedBox(height: 24),
            if (paymentProcess.isLoading) const PaymentStatusIndicator(),
            if (paymentProcess.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'Ошибка: ${paymentProcess.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (paymentProcess.response != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed('/subscription-success');
                  },
                  child: const Text('Перейти к подписке'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
