enum PaymentStatus { success, failed, pending, refunded }

class PaymentRecord {
  final String id;
  final String subscriptionId;
  final double amount;
  final DateTime date;
  final PaymentStatus status;
  final String paymentMethod;
  final String? transactionId;

  const PaymentRecord({
    required this.id,
    required this.subscriptionId,
    required this.amount,
    required this.date,
    required this.status,
    required this.paymentMethod,
    this.transactionId,
  });

  factory PaymentRecord.fromMap(Map<String, dynamic> map) {
    return PaymentRecord(
      id: map['id'] as String,
      subscriptionId: map['subscriptionId'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString() == 'PaymentStatus.' + (map['status'] as String),
      ),
      paymentMethod: map['paymentMethod'] as String,
      transactionId: map['transactionId'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'subscriptionId': subscriptionId,
    'amount': amount,
    'date': date.toIso8601String(),
    'status': status.name,
    'paymentMethod': paymentMethod,
    'transactionId': transactionId,
  };
}
