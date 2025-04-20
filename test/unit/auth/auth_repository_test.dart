import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mocks/firebase_mocks.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/repositories/firebase_auth_repository.dart';

void main() {
  group('AuthRepository', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockErrorHandler mockErrorHandler;
    late MockLogger mockLogger;
    late FirebaseAuthRepository repository;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockErrorHandler = MockErrorHandler();
      mockLogger = MockLogger();
      repository = FirebaseAuthRepository(
        mockFirebaseAuth,
        mockErrorHandler,
        mockLogger,
      );
    });

    test('should register user with email and password', () async {
      // Arrange
      // TODO: настройте моки и ожидаемое поведение
      // Act
      // TODO: вызовите метод регистрации
      // Assert
      // TODO: проверьте результат
    });

    test('should sign in user with email and password', () async {
      // Arrange
      // TODO
    });

    test('should sign out user', () async {
      // Arrange
      // TODO
    });

    test('should handle auth errors', () async {
      // Arrange
      // TODO
    });

    test('should get current user', () async {
      // Arrange
      // TODO
    });
  });
}
