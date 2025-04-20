import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blvl_17_04_tmp/src/core/utils/error_handler.dart';
import 'package:blvl_17_04_tmp/src/core/utils/logger.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/cache_manager.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/firestore_data_service.dart';

// Мок для FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Мок для User
class MockUser extends Mock implements User {}

// Мок для FirebaseFirestore
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// Мок для DocumentReference
class MockDocumentReference extends Mock implements DocumentReference {}

// Мок для CollectionReference
class MockCollectionReference extends Mock implements CollectionReference {}

// Мок для ErrorHandler
class MockErrorHandler extends Mock implements ErrorHandler {}

// Мок для Logger
class MockLogger extends Mock implements Logger {}

// Мок для CacheManager
class MockCacheManager extends Mock implements CacheManager {}

// Мок для FirestoreDataService
class MockFirestoreDataService extends Mock implements FirestoreDataService {}

// Добавляйте другие моки по мере необходимости
