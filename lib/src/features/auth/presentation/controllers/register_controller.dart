import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../domain/services/auth_service.dart';
import '../../../../domain/models/auth_credentials.dart';

class RegisterState {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final bool loading;
  final String? error;
  final bool success;

  RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.name = '',
    this.loading = false,
    this.error,
    this.success = false,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? name,
    bool? loading,
    String? error,
    bool? success,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      name: name ?? this.name,
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class RegisterController extends StateNotifier<RegisterState> {
  final IAuthService authService;
  RegisterController(this.authService) : super(RegisterState());

  void setEmail(String value) {
    state = state.copyWith(email: value, error: null);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, error: null);
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value, error: null);
  }

  void setName(String value) {
    state = state.copyWith(name: value, error: null);
  }

  Future<void> register() async {
    if (!ValidationUtils.isValidEmail(state.email)) {
      state = state.copyWith(error: 'Введите корректный email');
      return;
    }
    if (!ValidationUtils.isValidPassword(state.password)) {
      state = state.copyWith(error: 'Пароль должен быть не менее 6 символов');
      return;
    }
    if (state.password != state.confirmPassword) {
      state = state.copyWith(error: 'Пароли не совпадают');
      return;
    }
    if (state.name.trim().isEmpty) {
      state = state.copyWith(error: 'Введите имя');
      return;
    }
    state = state.copyWith(loading: true, error: null);
    try {
      await authService.register(
        AuthCredentials(email: state.email, password: state.password),
      );
      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
