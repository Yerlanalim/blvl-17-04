// TODO: Провайдеры для навигации (GoRouter, состояние навигации)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../router_notifier.dart';
import '../app_router.dart';

final routerNotifierProvider = ChangeNotifierProvider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);
  return createAppRouter(ref, notifier);
});
