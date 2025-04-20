import 'package:flutter/material.dart';
import '../../../../domain/models/subscription_status.dart';

class SubscriptionStatusBadge extends StatelessWidget {
  final SubscriptionStatus status;
  const SubscriptionStatusBadge({Key? key, required this.status})
    : super(key: key);

  Color _getColor() {
    switch (status) {
      case SubscriptionStatus.active:
        return Colors.green;
      case SubscriptionStatus.trial:
        return Colors.orange;
      case SubscriptionStatus.expired:
        return Colors.grey;
      case SubscriptionStatus.cancelled:
        return Colors.red;
      case SubscriptionStatus.pending:
        return Colors.blueAccent;
      case SubscriptionStatus.none:
        return Colors.black26;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(status.name, style: const TextStyle(color: Colors.white)),
    );
  }
}
