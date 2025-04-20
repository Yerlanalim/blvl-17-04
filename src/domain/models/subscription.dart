import 'subscription_status.dart';
import 'payment_record.dart';

class Subscription {
  final String id;
  final String userId;
  final String planId;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final bool autoRenew;
  final List<PaymentRecord> paymentRecords;

  const Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.autoRenew = false,
    this.paymentRecords = const [],
  });

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'] as String,
      userId: map['userId'] as String,
      planId: map['planId'] as String,
      status: SubscriptionStatus.values.firstWhere(
        (e) =>
            e.toString() == 'SubscriptionStatus.' + (map['status'] as String),
      ),
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      autoRenew: map['autoRenew'] ?? false,
      paymentRecords:
          (map['paymentRecords'] as List<dynamic>? ?? [])
              .map((e) => PaymentRecord.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'planId': planId,
    'status': status.name,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'autoRenew': autoRenew,
    'paymentRecords': paymentRecords.map((e) => e.toMap()).toList(),
  };
}
