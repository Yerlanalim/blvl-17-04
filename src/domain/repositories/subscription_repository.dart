import '../models/subscription.dart';
import '../models/subscription_plan.dart';
import '../models/payment_record.dart';

abstract class ISubscriptionRepository {
  Future<Subscription?> getCurrentSubscription(String userId);
  Future<List<Subscription>> getSubscriptions(String userId);
  Future<void> saveSubscription(Subscription sub);
  Future<void> updateSubscription(Subscription sub);
  Future<List<SubscriptionPlan>> getPlans();
  Future<List<PaymentRecord>> getPayments(String userId);
  Stream<Subscription?> watchSubscription(String userId);
}
