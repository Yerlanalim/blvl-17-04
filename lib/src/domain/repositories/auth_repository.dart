import '../models/auth_credentials.dart';
import '../models/auth_state.dart';
import '../enums/auth_provider.dart';
import '../models/user.dart';

abstract class IAuthRepository {
  Future<User> signUpWithEmailPassword(AuthCredentials credentials);
  Future<User> signInWithEmailPassword(AuthCredentials credentials);
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  User? getCurrentUser();
  Stream<AuthState> authStateChanges();
}
