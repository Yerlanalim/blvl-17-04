// TODO: Реализация RouterNotifier для отслеживания состояния авторизации

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/providers/auth_providers.dart';

/// RouterNotifier отслеживает изменения авторизации и уведомляет GoRouter
class RouterNotifier extends ChangeNotifier {
  final Ref ref;
  late final ProviderSubscription authSub;

  RouterNotifier(this.ref) {
    // Подписка на изменения состояния авторизации
    authSub = ref.listen<AsyncValue>(
      authStateProvider,
      (prev, next) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    authSub.close();
    super.dispose();
  }
}
