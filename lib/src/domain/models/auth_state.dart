import '../enums/auth_provider.dart';
import 'user.dart';

class AuthState {
  final User? user;
  final bool isAuthenticated;
  final AuthProvider? provider;
  final String? error;

  AuthState({
    this.user,
    this.isAuthenticated = false,
    this.provider,
    this.error,
  });

  AuthState copyWith({
    User? user,
    bool? isAuthenticated,
    AuthProvider? provider,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      provider: provider ?? this.provider,
      error: error ?? this.error,
    );
  }
}
