import 'package:meta/meta.dart';

@immutable
class PaymentError {
  final String
  code; // Например: 'card_declined', 'network_error', 'invalid_data', etc.
  final String message;
  final Map<String, dynamic>? details;

  const PaymentError({required this.code, required this.message, this.details});
}
