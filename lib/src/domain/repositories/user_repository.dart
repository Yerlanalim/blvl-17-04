import '../models/user.dart';
import '../models/user_profile.dart';
import '../interfaces/base_repository.dart';

/// Интерфейс репозитория пользователей
abstract class UserRepository extends BaseRepository<User> {
  /// Найти пользователя по email
  Future<User?> findByEmail(String email);

  /// Обновить профиль пользователя
  Future<void> updateProfile(String userId, UserProfile profile);
}
