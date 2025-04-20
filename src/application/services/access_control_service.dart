import '../../domain/services/subscription_manager.dart';
import '../../domain/models/subscription_status.dart';
import 'dart:async';

/// Централизованный сервис контроля доступа к премиум-контенту
class AccessControlService {
  final ISubscriptionManager _subscriptionManager;
  final Map<String, SubscriptionStatus> _statusCache = {};
  final Map<String, StreamSubscription> _subscriptions = {};

  AccessControlService(this._subscriptionManager);

  /// Проверка доступа пользователя к определённому типу контента
  Future<bool> hasAccess(
    String userId, {
    String? contentType,
    String? contentId,
  }) async {
    final status = await _getStatus(userId);
    // TODO: расширить логику для разных планов и типов контента
    return status == SubscriptionStatus.active ||
        status == SubscriptionStatus.trial;
  }

  /// Получить уровень доступа пользователя
  Future<SubscriptionStatus> getAccessLevel(String userId) async {
    return _getStatus(userId);
  }

  /// Принудительно обновить права доступа (например, после смены подписки)
  Future<void> refreshAccess(String userId) async {
    _statusCache.remove(userId);
    await _getStatus(userId, force: true);
  }

  /// Внутренний метод получения статуса с кэшированием
  Future<SubscriptionStatus> _getStatus(
    String userId, {
    bool force = false,
  }) async {
    if (!force && _statusCache.containsKey(userId)) {
      return _statusCache[userId]!;
    }
    final status = await _subscriptionManager.getSubscriptionStatus(userId);
    _statusCache[userId] = status;
    // Подписка на обновления статуса
    _subscriptions[userId]?.cancel();
    _subscriptions[userId] = _subscriptionManager
        .subscribeToStatusChanges(userId)
        .listen((newStatus) {
          _statusCache[userId] = newStatus as SubscriptionStatus;
        });
    return status;
  }

  /// Очистить кэш и подписки (например, при выходе пользователя)
  void dispose() {
    _subscriptions.values.forEach((s) => s.cancel());
    _subscriptions.clear();
    _statusCache.clear();
  }
}
