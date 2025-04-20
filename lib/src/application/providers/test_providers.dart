import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/repositories/firestore_test_repository.dart';
import '../../infrastructure/services/cache_manager.dart';
import '../services/test_engine.dart';
import '../services/test_session_manager.dart';

final testRepositoryProvider = Provider<FirestoreTestRepository>((ref) {
  final cacheManager = CacheManager();
  return FirestoreTestRepository(cacheManager: cacheManager);
});

final testEngineProvider = Provider<TestEngine?>((ref) {
  // Здесь будет логика инициализации TestEngine с тестом и сессией
  return null;
});

final testSessionManagerProvider = Provider<TestSessionManager>((ref) {
  return TestSessionManager();
});
