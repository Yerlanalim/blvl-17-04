import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/subscription_manager.dart';
import '../../application/services/subscription_manager_impl.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../infrastructure/repositories/firestore_subscription_repository.dart';
import '../../core/utils/error_handler.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import '../../infrastructure/services/cache_manager.dart';

final subscriptionManagerProvider = Provider<ISubscriptionManager>((ref) {
  final repo = ref.watch(subscriptionRepositoryProvider);
  final errorHandler = ref.watch(errorHandlerProvider);
  return SubscriptionManager(repository: repo, errorHandler: errorHandler);
});

final subscriptionRepositoryProvider = Provider<ISubscriptionRepository>((ref) {
  final firestore = ref.watch(firestoreDataServiceProvider);
  final cache = ref.watch(cacheManagerProvider);
  final errorHandler = ref.watch(errorHandlerProvider);
  return FirestoreSubscriptionRepository(
    firestoreDataService: firestore,
    cacheManager: cache,
    errorHandler: errorHandler,
  );
});

final firestoreDataServiceProvider = Provider<FirestoreDataService>(
  (ref) => throw UnimplementedError(),
);
final cacheManagerProvider = Provider<CacheManager>(
  (ref) => throw UnimplementedError(),
);
final errorHandlerProvider = Provider<ErrorHandler>(
  (ref) => throw UnimplementedError(),
);

final subscriptionStatusProvider = FutureProvider.family((ref, String userId) {
  final manager = ref.watch(subscriptionManagerProvider);
  return manager.getSubscriptionStatus(userId);
});

final availablePlansProvider = FutureProvider((ref) {
  final manager = ref.watch(subscriptionManagerProvider);
  return manager.getAvailablePlans();
});

final hasPremiumAccessProvider = FutureProvider.family((ref, String userId) {
  final manager = ref.watch(subscriptionManagerProvider);
  return manager.hasPremiumAccess(userId);
});

final subscriptionHistoryProvider = FutureProvider.family((ref, String userId) {
  final manager = ref.watch(subscriptionManagerProvider);
  return manager.getSubscriptionHistory(userId);
});

final paymentHistoryProvider = FutureProvider.family((ref, String userId) {
  final manager = ref.watch(subscriptionManagerProvider);
  return manager.getPaymentHistory(userId);
});

final subscriptionStatusStreamProvider = StreamProvider.family((
  ref,
  String userId,
) {
  final manager = ref.watch(subscriptionManagerProvider);
  return manager.subscribeToStatusChanges(userId);
});
