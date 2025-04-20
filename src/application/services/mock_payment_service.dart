import 'dart:async';
import 'dart:math';

import '../../domain/services/payment_service.dart';
import '../../domain/models/payment_request.dart';
import '../../domain/models/payment_response.dart';
import '../../domain/models/payment_method.dart';
import '../../domain/models/payment_error.dart';

/// Конфигурация сценариев для тестирования
class MockPaymentConfig {
  final Duration delay;
  final double failRate; // 0.0 - всегда успех, 1.0 - всегда ошибка
  final double cancelRate;
  final double refundRate;

  const MockPaymentConfig({
    this.delay = const Duration(seconds: 2),
    this.failRate = 0.1,
    this.cancelRate = 0.05,
    this.refundRate = 0.05,
  });
}

class MockPaymentService implements IPaymentService {
  final MockPaymentConfig config;
  final Map<String, PaymentResponse> _payments = {};
  final Map<String, List<PaymentResponse>> _userPayments = {};
  final Random _random = Random();

  MockPaymentService({this.config = const MockPaymentConfig()});

  @override
  Future<PaymentResponse> initPayment(PaymentRequest request) async {
    await Future.delayed(config.delay);
    final id =
        'pay_${DateTime.now().millisecondsSinceEpoch}_${_random.nextInt(10000)}';
    final scenario = _chooseScenario();
    final now = DateTime.now();
    PaymentResponse response;
    switch (scenario) {
      case PaymentStatus.success:
        response = PaymentResponse(
          paymentId: id,
          status: PaymentStatus.success,
          timestamp: now,
          message: 'Платеж успешно проведен',
        );
        break;
      case PaymentStatus.failed:
        response = PaymentResponse(
          paymentId: id,
          status: PaymentStatus.failed,
          timestamp: now,
          message: 'Платеж отклонен',
          error: PaymentError(
            code: 'card_declined',
            message: 'Карта отклонена банком',
          ),
        );
        break;
      case PaymentStatus.cancelled:
        response = PaymentResponse(
          paymentId: id,
          status: PaymentStatus.cancelled,
          timestamp: now,
          message: 'Платеж отменен',
        );
        break;
      default:
        response = PaymentResponse(
          paymentId: id,
          status: PaymentStatus.pending,
          timestamp: now,
          message: 'Платеж в обработке',
        );
    }
    _payments[id] = response;
    _userPayments.putIfAbsent(request.userId, () => []).add(response);
    return response;
  }

  @override
  Future<PaymentResponse> getPaymentStatus(String paymentId) async {
    await Future.delayed(config.delay ~/ 2);
    return _payments[paymentId] ??
        PaymentResponse(
          paymentId: paymentId,
          status: PaymentStatus.failed,
          timestamp: DateTime.now(),
          message: 'Платеж не найден',
          error: PaymentError(code: 'not_found', message: 'Платеж не найден'),
        );
  }

  @override
  Future<List<PaymentResponse>> getPaymentHistory(String userId) async {
    await Future.delayed(config.delay ~/ 2);
    return List.unmodifiable(_userPayments[userId] ?? []);
  }

  @override
  Future<PaymentResponse> cancelPayment(String paymentId) async {
    await Future.delayed(config.delay);
    final old = _payments[paymentId];
    if (old == null) {
      return PaymentResponse(
        paymentId: paymentId,
        status: PaymentStatus.failed,
        timestamp: DateTime.now(),
        message: 'Платеж не найден',
        error: PaymentError(code: 'not_found', message: 'Платеж не найден'),
      );
    }
    final cancelled =
        old.status == PaymentStatus.success
            ? PaymentResponse(
              paymentId: paymentId,
              status: PaymentStatus.cancelled,
              timestamp: DateTime.now(),
              message: 'Платеж отменен',
            )
            : old;
    _payments[paymentId] = cancelled;
    return cancelled;
  }

  @override
  Future<PaymentResponse> refundPayment(String paymentId) async {
    await Future.delayed(config.delay);
    final old = _payments[paymentId];
    if (old == null) {
      return PaymentResponse(
        paymentId: paymentId,
        status: PaymentStatus.failed,
        timestamp: DateTime.now(),
        message: 'Платеж не найден',
        error: PaymentError(code: 'not_found', message: 'Платеж не найден'),
      );
    }
    final refunded =
        old.status == PaymentStatus.success
            ? PaymentResponse(
              paymentId: paymentId,
              status: PaymentStatus.refunded,
              timestamp: DateTime.now(),
              message: 'Платеж возвращен',
            )
            : old;
    _payments[paymentId] = refunded;
    return refunded;
  }

  @override
  Future<bool> validatePaymentInfo(PaymentRequest request) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Примитивная валидация для теста
    if (request.amount <= 0) return false;
    if (request.paymentMethod.type == 'card') {
      return (request.paymentMethod.cardNumber?.length ?? 0) >= 12;
    }
    return true;
  }

  PaymentStatus _chooseScenario() {
    final r = _random.nextDouble();
    if (r < config.failRate) return PaymentStatus.failed;
    if (r < config.failRate + config.cancelRate) return PaymentStatus.cancelled;
    if (r < config.failRate + config.cancelRate + config.refundRate)
      return PaymentStatus.refunded;
    return PaymentStatus.success;
  }
}
