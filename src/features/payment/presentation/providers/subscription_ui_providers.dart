import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/subscription_screen_controller.dart';
import '../../../../domain/models/subscription_plan.dart';
import '../../../../domain/models/subscription_status.dart';
import '../../../../domain/models/subscription.dart';
import '../../../../domain/models/payment_record.dart';
import '../../../../application/providers/subscription_providers.dart' as sub;
import '../../../../application/providers/payment_providers.dart' as pay;

// TODO: Реализовать провайдеры для управления состоянием UI подписки

// Провайдер для получения доступных планов подписки
final subscriptionPlansUiProvider = sub.availablePlansProvider;

// Провайдер для получения статуса подписки пользователя
final subscriptionStatusUiProvider = sub.subscriptionStatusProvider;

// Провайдер для получения истории подписок пользователя
final subscriptionHistoryUiProvider = sub.subscriptionHistoryProvider;

// Провайдер для получения истории платежей пользователя
final paymentHistoryUiProvider = pay.paymentHistoryProvider;

// Провайдер для контроллера UI подписки
final subscriptionScreenControllerProvider =
    ChangeNotifierProvider<SubscriptionScreenController>((ref) {
      return SubscriptionScreenController();
    });
