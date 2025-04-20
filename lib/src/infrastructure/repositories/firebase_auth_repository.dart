import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/models/auth_credentials.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/enums/auth_provider.dart';
import '../../domain/models/user.dart';
import '../../domain/models/user_profile.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final fb.FirebaseAuth _firebaseAuth;
  final ErrorHandler _errorHandler;
  final Logger _logger;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuthRepository(this._firebaseAuth, this._errorHandler, this._logger);

  @override
  Future<User> signUpWithEmailPassword(AuthCredentials credentials) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password!,
      );
      final fbUser = userCredential.user;
      if (fbUser == null) {
        throw Exception('Не удалось создать пользователя');
      }
      // Создаем профиль пользователя в Firestore
      final profile = UserProfile(displayName: '', achievements: []);
      final user = User(
        id: fbUser.uid,
        email: fbUser.email ?? '',
        profile: profile,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        isPremium: false,
      );
      await _firestore.collection('users').doc(fbUser.uid).set(user.toJson());
      _logger.info('Пользователь зарегистрирован: ${fbUser.uid}');
      return user;
    } catch (e, st) {
      final appException = _errorHandler.handle(e, st);
      _logger.error(
        'Ошибка регистрации: ${appException.message}',
        error: e,
        stackTrace: st,
      );
      throw appException;
    }
  }

  @override
  Future<User> signInWithEmailPassword(AuthCredentials credentials) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password!,
      );
      final fbUser = userCredential.user;
      if (fbUser == null) {
        throw Exception('Не удалось войти');
      }
      // Загружаем профиль пользователя из Firestore
      final doc = await _firestore.collection('users').doc(fbUser.uid).get();
      if (!doc.exists) {
        throw Exception('Профиль пользователя не найден');
      }
      final user = User.fromJson(doc.data()!);
      _logger.info('Пользователь вошел: ${fbUser.uid}');
      return user;
    } catch (e, st) {
      final appException = _errorHandler.handle(e, st);
      _logger.error(
        'Ошибка входа: ${appException.message}',
        error: e,
        stackTrace: st,
      );
      throw appException;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      // TODO: Реализовать Google Sign-In для web и mobile отдельно
      throw UnimplementedError(
        'Google Sign-In реализуется отдельно для web и mobile',
      );
    } catch (e, st) {
      final appException = _errorHandler.handle(e, st);
      _logger.error(
        'Ошибка Google Sign-In: ${appException.message}',
        error: e,
        stackTrace: st,
      );
      throw appException;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _logger.info('Пользователь вышел из системы');
    } catch (e, st) {
      final appException = _errorHandler.handle(e, st);
      _logger.error(
        'Ошибка выхода: ${appException.message}',
        error: e,
        stackTrace: st,
      );
      throw appException;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      _logger.info('Отправлено письмо для сброса пароля: $email');
    } catch (e, st) {
      final appException = _errorHandler.handle(e, st);
      _logger.error(
        'Ошибка сброса пароля: ${appException.message}',
        error: e,
        stackTrace: st,
      );
      throw appException;
    }
  }

  @override
  User? getCurrentUser() {
    final fbUser = _firebaseAuth.currentUser;
    if (fbUser == null) return null;
    // В реальном приложении лучше использовать async и загрузить профиль из Firestore
    // Здесь возвращаем только базовую информацию
    return User(
      id: fbUser.uid,
      email: fbUser.email ?? '',
      profile: UserProfile(displayName: '', achievements: []),
      createdAt: fbUser.metadata.creationTime ?? DateTime.now(),
      lastLogin: fbUser.metadata.lastSignInTime,
      isPremium: false,
    );
  }

  @override
  Stream<AuthState> authStateChanges() async* {
    await for (final fbUser in _firebaseAuth.authStateChanges()) {
      if (fbUser == null) {
        yield AuthState(isAuthenticated: false);
      } else {
        try {
          final doc =
              await _firestore.collection('users').doc(fbUser.uid).get();
          if (!doc.exists) {
            yield AuthState(isAuthenticated: false, error: 'Профиль не найден');
            continue;
          }
          final user = User.fromJson(doc.data()!);
          yield AuthState(
            user: user,
            isAuthenticated: true,
            provider:
                AuthProvider.email, // TODO: определить провайдера по факту
          );
        } catch (e, st) {
          final appException = _errorHandler.handle(e, st);
          yield AuthState(isAuthenticated: false, error: appException.message);
        }
      }
    }
  }
}
