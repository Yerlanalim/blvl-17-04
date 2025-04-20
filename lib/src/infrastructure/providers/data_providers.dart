import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../services/firestore_data_service.dart';
import '../services/firebase_storage_service.dart';
import '../services/cache_manager.dart';

/// Провайдер CacheManager (singleton)
final cacheManagerProvider = Provider<CacheManager>((ref) => CacheManager());

/// Провайдер FirestoreDataService (singleton)
final firestoreDataServiceProvider = Provider<FirestoreDataService>((ref) {
  final firestore = FirebaseFirestore.instance;
  final errorHandler = ref.read(errorHandlerProvider);
  final logger = ref.read(loggerProvider);
  return FirestoreDataService(
    firestore: firestore,
    errorHandler: errorHandler,
    logger: logger,
  );
});

/// Провайдер FirebaseStorageService (singleton)
final firebaseStorageServiceProvider = Provider<FirebaseStorageService>((ref) {
  final storage = FirebaseStorage.instance;
  final errorHandler = ref.read(errorHandlerProvider);
  final logger = ref.read(loggerProvider);
  return FirebaseStorageService(
    storage: storage,
    errorHandler: errorHandler,
    logger: logger,
  );
});
