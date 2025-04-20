import 'package:meta/meta.dart';
import 'payment_method.dart';

@immutable
class PaymentRequest {
  final String userId;
  final double amount;
  final String currency;
  final PaymentMethod paymentMethod;
  final String? description;
  final Map<String, dynamic>? extra;

  const PaymentRequest({
    required this.userId,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    this.description,
    this.extra,
  });
}
