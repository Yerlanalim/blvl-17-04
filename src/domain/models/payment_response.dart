import 'package:meta/meta.dart';
import 'payment_error.dart';

enum PaymentStatus { pending, success, failed, cancelled, refunded }

@immutable
class PaymentResponse {
  final String paymentId;
  final PaymentStatus status;
  final String? message;
  final DateTime timestamp;
  final PaymentError? error;
  final Map<String, dynamic>? extra;

  const PaymentResponse({
    required this.paymentId,
    required this.status,
    required this.timestamp,
    this.message,
    this.error,
    this.extra,
  });
}
