import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../domain/services/auth_service.dart';

class ForgotPasswordState {
  final String email;
  final bool loading;
  final String? error;
  final bool success;

  ForgotPasswordState({
    this.email = '',
    this.loading = false,
    this.error,
    this.success = false,
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? loading,
    String? error,
    bool? success,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final IAuthService authService;
  ForgotPasswordController(this.authService) : super(ForgotPasswordState());

  void setEmail(String value) {
    state = state.copyWith(email: value, error: null);
  }

  Future<void> sendResetEmail() async {
    if (!ValidationUtils.isValidEmail(state.email)) {
      state = state.copyWith(error: 'Введите корректный email');
      return;
    }
    state = state.copyWith(loading: true, error: null);
    try {
      await authService.resetPassword(state.email);
      state = state.copyWith(loading: false, success: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
