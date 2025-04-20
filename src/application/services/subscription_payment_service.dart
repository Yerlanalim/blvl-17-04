import '../../domain/services/payment_service.dart';
import '../../domain/models/payment_request.dart';
import '../../domain/models/payment_response.dart';
import '../../domain/models/payment_error.dart';
import '../../domain/models/payment_method.dart';
import '../../domain/models/subscription.dart';
import '../../domain/services/subscription_manager.dart';
import '../../domain/models/subscription_plan.dart';

/// Сервис для связи платежей и подписок
class SubscriptionPaymentService {
  final IPaymentService paymentService;
  final ISubscriptionManager subscriptionManager;

  SubscriptionPaymentService({
    required this.paymentService,
    required this.subscriptionManager,
  });

  /// Оформление подписки с оплатой
  Future<PaymentResponse> subscribeWithPayment({
    required String userId,
    required SubscriptionPlan plan,
    required PaymentMethod paymentMethod,
  }) async {
    final request = PaymentRequest(
      userId: userId,
      amount: plan.price,
      currency: 'KZT', // Можно расширить, если появится поле currency
      paymentMethod: paymentMethod,
      description: 'Оплата подписки: ${plan.name}',
    );
    final response = await paymentService.initPayment(request);
    if (response.status == PaymentStatus.success) {
      await subscriptionManager.activateSubscription(userId, plan);
    } else if (response.status == PaymentStatus.failed ||
        response.status == PaymentStatus.cancelled) {
      await subscriptionManager.deactivateSubscription(userId);
    }
    return response;
  }

  /// Получение истории платежей пользователя
  Future<List<PaymentResponse>> getUserPaymentHistory(String userId) {
    return paymentService.getPaymentHistory(userId);
  }

  /// Возврат платежа и обновление подписки
  Future<PaymentResponse> refundSubscriptionPayment(
    String paymentId,
    String userId,
    SubscriptionPlan plan,
  ) async {
    final response = await paymentService.refundPayment(paymentId);
    if (response.status == PaymentStatus.refunded) {
      await subscriptionManager.deactivateSubscription(userId);
    }
    return response;
  }
}
