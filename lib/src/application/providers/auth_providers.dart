import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/auth_service.dart';
import '../../infrastructure/services/cache_manager.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service_impl.dart';
import '../services/session_manager.dart';
import '../services/user_profile_initializer.dart';
import '../../infrastructure/providers/auth_providers.dart';

final authServiceProvider = Provider<IAuthService>((ref) {
  final authRepository =
      ref.watch(firebaseAuthRepositoryProvider) as IAuthRepository;
  final cacheManager = CacheManager();
  final firestoreService = FirestoreDataService(
    firestore: /* TODO: передать FirebaseFirestore.instance */
        throw UnimplementedError(),
    errorHandler: /* TODO: передать ErrorHandler */ throw UnimplementedError(),
    logger: /* TODO: передать Logger */ throw UnimplementedError(),
  );
  final sessionManager = SessionManager();
  final profileInitializer = UserProfileInitializer();
  return AuthServiceImpl(
    authRepository: authRepository,
    cacheManager: cacheManager,
    firestoreService: firestoreService,
    sessionManager: sessionManager,
    profileInitializer: profileInitializer,
  );
});

final authStateProvider = StreamProvider((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.observeAuthState();
});

final currentUserProvider = Provider((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.getCurrentUser();
});
