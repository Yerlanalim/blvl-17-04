// TODO: Реализация защиты маршрутов (route guards)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/providers/auth_providers.dart';

/// Проверка авторизации пользователя
bool isUserAuthenticated(WidgetRef ref) {
  final authState = ref.watch(authStateProvider);
  return authState.asData?.value.isAuthenticated == true;
}

/// Функция для редиректа неавторизованных пользователей
String? redirectIfUnauthenticated(WidgetRef ref, String intendedPath) {
  final authState = ref.watch(authStateProvider);
  if (authState.asData?.value.isAuthenticated != true) {
    return '/login?redirect=$intendedPath';
  }
  return null;
}
