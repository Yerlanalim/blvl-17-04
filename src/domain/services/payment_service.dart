import '../models/payment_request.dart';
import '../models/payment_response.dart';
import '../models/payment_method.dart';

abstract class IPaymentService {
  /// Инициализация нового платежа
  Future<PaymentResponse> initPayment(PaymentRequest request);

  /// Получение статуса платежа по идентификатору
  Future<PaymentResponse> getPaymentStatus(String paymentId);

  /// Получение истории платежей пользователя
  Future<List<PaymentResponse>> getPaymentHistory(String userId);

  /// Отмена платежа
  Future<PaymentResponse> cancelPayment(String paymentId);

  /// Возврат платежа
  Future<PaymentResponse> refundPayment(String paymentId);

  /// Валидация платежной информации
  Future<bool> validatePaymentInfo(PaymentRequest request);
}
