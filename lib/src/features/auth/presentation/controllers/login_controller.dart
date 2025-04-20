import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../domain/services/auth_service.dart';
import '../../../../domain/models/auth_credentials.dart';

class LoginState {
  final String email;
  final String password;
  final bool loading;
  final String? error;
  final bool success;

  LoginState({
    this.email = '',
    this.password = '',
    this.loading = false,
    this.error,
    this.success = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? loading,
    String? error,
    bool? success,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final IAuthService authService;
  LoginController(this.authService) : super(LoginState());

  void setEmail(String value) {
    state = state.copyWith(email: value, error: null);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, error: null);
  }

  Future<void> login() async {
    if (!ValidationUtils.isValidEmail(state.email)) {
      state = state.copyWith(error: 'Введите корректный email');
      return;
    }
    if (!ValidationUtils.isValidPassword(state.password)) {
      state = state.copyWith(error: 'Пароль должен быть не менее 6 символов');
      return;
    }
    state = state.copyWith(loading: true, error: null);
    try {
      await authService.login(
        AuthCredentials(email: state.email, password: state.password),
      );
      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(loading: true, error: null);
    try {
      await authService.loginWithGoogle();
      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
