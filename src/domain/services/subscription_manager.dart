abstract class ISubscriptionManager {
  Future<SubscriptionStatus> getSubscriptionStatus(String userId);
  Future<void> activateSubscription(String userId, SubscriptionPlan plan);
  Future<void> deactivateSubscription(String userId);
  Future<List<SubscriptionPlan>> getAvailablePlans();
  Future<bool> hasPremiumAccess(String userId);
  Future<List<Subscription>> getSubscriptionHistory(String userId);
  Future<List<PaymentRecord>> getPaymentHistory(String userId);
  Stream<SubscriptionStatus> subscribeToStatusChanges(String userId);
}
