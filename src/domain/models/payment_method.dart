import 'package:meta/meta.dart';

@immutable
class PaymentMethod {
  final String type; // Например: 'card', 'kaspi', 'test', 'apple_pay', etc.
  final String? cardNumber;
  final String? cardHolder;
  final String? expiryDate;
  final String? cvv;
  final Map<String, dynamic>? extra;

  const PaymentMethod({
    required this.type,
    this.cardNumber,
    this.cardHolder,
    this.expiryDate,
    this.cvv,
    this.extra,
  });
}
