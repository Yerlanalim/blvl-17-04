import 'package:flutter/material.dart';
import '../../../../domain/models/subscription_plan.dart';
import '../../../../domain/models/payment_request.dart';
import '../../../../domain/models/payment_method.dart';

class PaymentForm extends StatelessWidget {
  final SubscriptionPlan plan;
  final String? paymentMethodType;
  final String? promoCode;
  final String userId;
  final String currency;
  final void Function(PaymentRequest) onSubmit;
  final bool isProcessing;

  const PaymentForm({
    Key? key,
    required this.plan,
    this.paymentMethodType,
    this.promoCode,
    required this.userId,
    this.currency = 'KZT',
    required this.onSubmit,
    this.isProcessing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed:
              isProcessing || paymentMethodType == null
                  ? null
                  : () {
                    final paymentMethod = PaymentMethod(
                      type: paymentMethodType!,
                    );
                    final request = PaymentRequest(
                      userId: userId,
                      amount: plan.price,
                      currency: currency,
                      paymentMethod: paymentMethod,
                      description: plan.name,
                      extra: {
                        'planId': plan.id,
                        if (promoCode != null) 'promoCode': promoCode,
                      },
                    );
                    onSubmit(request);
                  },
          child:
              isProcessing
                  ? const CircularProgressIndicator()
                  : const Text('Оплатить'),
        ),
      ],
    );
  }
}
