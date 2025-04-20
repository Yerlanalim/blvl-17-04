import '../models/user.dart';
import '../models/user_profile.dart';
import '../models/auth_credentials.dart';
import '../models/auth_state.dart';

abstract class IAuthService {
  /// Регистрация пользователя
  Future<User> register(AuthCredentials credentials);

  /// Вход пользователя
  Future<User> login(AuthCredentials credentials);

  /// Вход через Google
  Future<User> loginWithGoogle();

  /// Выход пользователя
  Future<void> logout();

  /// Получить текущего пользователя
  User? getCurrentUser();

  /// Поток состояния аутентификации
  Stream<AuthState> observeAuthState();

  /// Получить профиль пользователя
  Future<UserProfile> getProfile(String userId);

  /// Обновить профиль пользователя
  Future<void> updateProfile(String userId, UserProfile profile);

  /// Поток изменений профиля пользователя
  Stream<UserProfile> observeProfile(String userId);

  /// Сброс пароля
  Future<void> resetPassword(String email);

  /// Обновить токен аутентификации
  Future<void> refreshToken();
}
