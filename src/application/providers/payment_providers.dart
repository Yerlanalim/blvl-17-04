import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/payment_service.dart';
import '../services/mock_payment_service.dart';
import '../services/subscription_payment_service.dart';
import '../../domain/services/subscription_manager.dart';
import 'subscription_providers.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../domain/models/payment_response.dart';
import '../../domain/models/payment_request.dart';

/// Провайдер для заглушки платежного сервиса
final paymentServiceProvider = Provider<IPaymentService>((ref) {
  return MockPaymentService();
});

/// Провайдер для сервиса связи платежей и подписок
final subscriptionPaymentServiceProvider = Provider<SubscriptionPaymentService>(
  (ref) {
    final paymentService = ref.watch(paymentServiceProvider);
    final subscriptionManager = ref.watch(subscriptionManagerProvider);
    return SubscriptionPaymentService(
      paymentService: paymentService,
      subscriptionManager: subscriptionManager,
    );
  },
);

/// Провайдер для отслеживания статуса платежа по id
final paymentStatusProvider = FutureProvider.family.autoDispose((
  ref,
  String paymentId,
) async {
  final paymentService = ref.watch(paymentServiceProvider);
  return paymentService.getPaymentStatus(paymentId);
});

/// Провайдер для получения истории платежей пользователя
final paymentHistoryProvider = FutureProvider.family.autoDispose((
  ref,
  String userId,
) async {
  final paymentService = ref.watch(paymentServiceProvider);
  return paymentService.getPaymentHistory(userId);
});

class PaymentProcessState {
  final bool isLoading;
  final PaymentResponse? response;
  final String? error;

  const PaymentProcessState({
    this.isLoading = false,
    this.response,
    this.error,
  });

  PaymentProcessState copyWith({
    bool? isLoading,
    PaymentResponse? response,
    String? error,
  }) => PaymentProcessState(
    isLoading: isLoading ?? this.isLoading,
    response: response ?? this.response,
    error: error ?? this.error,
  );
}

class PaymentProcessNotifier extends StateNotifier<PaymentProcessState> {
  final IPaymentService paymentService;
  PaymentProcessNotifier(this.paymentService)
    : super(const PaymentProcessState());

  Future<void> startPayment(PaymentRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await paymentService.initPayment(request);
      state = state.copyWith(isLoading: false, response: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const PaymentProcessState();
  }
}

final paymentProcessProvider = StateNotifierProvider.autoDispose<
  PaymentProcessNotifier,
  PaymentProcessState
>((ref) {
  final paymentService = ref.watch(paymentServiceProvider);
  return PaymentProcessNotifier(paymentService);
});

// Провайдер для управления процессом оплаты (например, AsyncNotifier/StateNotifier)
// Можно расширить для сложных сценариев
