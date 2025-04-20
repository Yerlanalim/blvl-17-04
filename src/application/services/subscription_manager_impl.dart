import '../../domain/services/subscription_manager.dart';
import '../../domain/models/subscription.dart';
import '../../domain/models/subscription_plan.dart';
import '../../domain/models/subscription_status.dart';
import '../../domain/models/payment_record.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../core/utils/error_handler.dart';
import 'dart:async';

class SubscriptionManager implements ISubscriptionManager {
  final ISubscriptionRepository _repository;
  final ErrorHandler _errorHandler;

  final Map<String, StreamController<SubscriptionStatus>> _statusControllers =
      {};

  SubscriptionManager({
    required ISubscriptionRepository repository,
    required ErrorHandler errorHandler,
  }) : _repository = repository,
       _errorHandler = errorHandler;

  @override
  Future<SubscriptionStatus> getSubscriptionStatus(String userId) async {
    try {
      final sub = await _repository.getCurrentSubscription(userId);
      return sub?.status ?? SubscriptionStatus.none;
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return SubscriptionStatus.none;
    }
  }

  @override
  Future<void> activateSubscription(
    String userId,
    SubscriptionPlan plan,
  ) async {
    try {
      final now = DateTime.now();
      final sub = Subscription(
        id: '${userId}_${plan.id}_' + now.millisecondsSinceEpoch.toString(),
        userId: userId,
        planId: plan.id,
        status:
            plan.isTrial ? SubscriptionStatus.trial : SubscriptionStatus.active,
        startDate: now,
        endDate: now.add(plan.duration),
        autoRenew: !plan.isTrial,
        paymentRecords: [],
      );
      await _repository.saveSubscription(sub);
      _notifyStatus(userId, sub.status);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> deactivateSubscription(String userId) async {
    try {
      final sub = await _repository.getCurrentSubscription(userId);
      if (sub == null) return;
      final updated = Subscription(
        id: sub.id,
        userId: sub.userId,
        planId: sub.planId,
        status: SubscriptionStatus.cancelled,
        startDate: sub.startDate,
        endDate: sub.endDate,
        autoRenew: false,
        paymentRecords: sub.paymentRecords,
      );
      await _repository.updateSubscription(updated);
      _notifyStatus(userId, SubscriptionStatus.cancelled);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<List<SubscriptionPlan>> getAvailablePlans() async {
    try {
      return await _repository.getPlans();
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return [];
    }
  }

  @override
  Future<bool> hasPremiumAccess(String userId) async {
    try {
      final sub = await _repository.getCurrentSubscription(userId);
      if (sub == null) return false;
      return sub.status == SubscriptionStatus.active ||
          sub.status == SubscriptionStatus.trial;
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return false;
    }
  }

  @override
  Future<List<Subscription>> getSubscriptionHistory(String userId) async {
    try {
      return await _repository.getSubscriptions(userId);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return [];
    }
  }

  @override
  Future<List<PaymentRecord>> getPaymentHistory(String userId) async {
    try {
      return await _repository.getPayments(userId);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return [];
    }
  }

  @override
  Stream<SubscriptionStatus> subscribeToStatusChanges(String userId) {
    if (!_statusControllers.containsKey(userId)) {
      final controller = StreamController<SubscriptionStatus>.broadcast();
      _repository.watchSubscription(userId).listen((sub) {
        controller.add(sub?.status ?? SubscriptionStatus.none);
      });
      _statusControllers[userId] = controller;
    }
    return _statusControllers[userId]!.stream;
  }

  void _notifyStatus(String userId, SubscriptionStatus status) {
    if (_statusControllers.containsKey(userId)) {
      _statusControllers[userId]!.add(status);
    }
  }
}
