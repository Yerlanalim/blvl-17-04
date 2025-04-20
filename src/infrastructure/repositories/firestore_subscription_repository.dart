import '../../domain/repositories/subscription_repository.dart';
import '../../domain/models/subscription.dart';
import '../../domain/models/subscription_plan.dart';
import '../../domain/models/payment_record.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import '../../infrastructure/services/cache_manager.dart';
import '../../core/utils/error_handler.dart';

class FirestoreSubscriptionRepository implements ISubscriptionRepository {
  final FirestoreDataService _firestoreDataService;
  final CacheManager _cacheManager;
  final ErrorHandler _errorHandler;

  FirestoreSubscriptionRepository({
    required FirestoreDataService firestoreDataService,
    required CacheManager cacheManager,
    required ErrorHandler errorHandler,
  }) : _firestoreDataService = firestoreDataService,
       _cacheManager = cacheManager,
       _errorHandler = errorHandler;

  static const _subscriptionCollection = 'subscriptions';
  static const _plansCollection = 'subscription_plans';
  static const _paymentsSubcollection = 'payments';

  @override
  Future<Subscription?> getCurrentSubscription(String userId) async {
    final cacheKey = 'current_subscription_$userId';
    try {
      final cached = _cacheManager.get<Subscription>(cacheKey);
      if (cached != null && !_cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      final docs = await _firestoreDataService.getList<Map<String, dynamic>>(
        _subscriptionCollection,
      );
      final userSubs =
          docs
              .map((e) => Subscription.fromMap(e))
              .where((s) => s.userId == userId)
              .toList();
      final current = userSubs.firstWhere(
        (s) =>
            s.status == SubscriptionStatus.active ||
            s.status == SubscriptionStatus.trial,
        orElse: () => userSubs.isNotEmpty ? userSubs.first : null,
      );
      if (current != null) {
        _cacheManager.set<Subscription>(cacheKey, current);
      }
      return current;
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return null;
    }
  }

  @override
  Future<List<Subscription>> getSubscriptions(String userId) async {
    final cacheKey = 'subscriptions_$userId';
    try {
      final cached = _cacheManager.get<List<Subscription>>(cacheKey);
      if (cached != null && !_cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      final docs = await _firestoreDataService.getList<Map<String, dynamic>>(
        _subscriptionCollection,
      );
      final userSubs =
          docs
              .map((e) => Subscription.fromMap(e))
              .where((s) => s.userId == userId)
              .toList();
      _cacheManager.set<List<Subscription>>(cacheKey, userSubs);
      return userSubs;
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return [];
    }
  }

  @override
  Future<void> saveSubscription(Subscription sub) async {
    try {
      await _firestoreDataService.create<Map<String, dynamic>>(
        _subscriptionCollection,
        sub.toMap(),
      );
      _cacheManager.invalidate('subscriptions_${sub.userId}');
      _cacheManager.invalidate('current_subscription_${sub.userId}');
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> updateSubscription(Subscription sub) async {
    try {
      await _firestoreDataService.update(
        _subscriptionCollection,
        sub.id,
        sub.toMap(),
      );
      _cacheManager.invalidate('subscriptions_${sub.userId}');
      _cacheManager.invalidate('current_subscription_${sub.userId}');
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<List<SubscriptionPlan>> getPlans() async {
    const cacheKey = 'subscription_plans';
    try {
      final cached = _cacheManager.get<List<SubscriptionPlan>>(cacheKey);
      if (cached != null && !_cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      final docs = await _firestoreDataService.getList<Map<String, dynamic>>(
        _plansCollection,
      );
      final plans = docs.map((e) => SubscriptionPlan.fromMap(e)).toList();
      _cacheManager.set<List<SubscriptionPlan>>(cacheKey, plans);
      return plans;
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return [];
    }
  }

  @override
  Future<List<PaymentRecord>> getPayments(String userId) async {
    final cacheKey = 'payments_$userId';
    try {
      final cached = _cacheManager.get<List<PaymentRecord>>(cacheKey);
      if (cached != null && !_cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      final subs = await getSubscriptions(userId);
      final payments = <PaymentRecord>[];
      for (final sub in subs) {
        payments.addAll(sub.paymentRecords);
      }
      _cacheManager.set<List<PaymentRecord>>(cacheKey, payments);
      return payments;
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return [];
    }
  }

  @override
  Stream<Subscription?> watchSubscription(String userId) async* {
    try {
      final firestore = _firestoreDataService.firestore;
      final query = firestore
          .collection(_subscriptionCollection)
          .where('userId', isEqualTo: userId);
      await for (final snapshot in query.snapshots()) {
        if (snapshot.docs.isEmpty) {
          yield null;
          continue;
        }
        final docs = snapshot.docs.map((d) => d.data()).toList();
        final subs = docs.map((e) => Subscription.fromMap(e)).toList();
        final current = subs.firstWhere(
          (s) =>
              s.status == SubscriptionStatus.active ||
              s.status == SubscriptionStatus.trial,
          orElse: () => subs.isNotEmpty ? subs.first : null,
        );
        if (current != null) {
          _cacheManager.set<Subscription>(
            'current_subscription_$userId',
            current,
          );
        }
        yield current;
      }
    } catch (e, st) {
      _errorHandler.handle(e, st);
      yield null;
    }
  }
}
