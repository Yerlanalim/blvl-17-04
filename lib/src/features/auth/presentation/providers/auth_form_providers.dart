import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/login_controller.dart';
import '../controllers/register_controller.dart';
import '../controllers/forgot_password_controller.dart';
import '../../../../application/providers/auth_providers.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
      final authService = ref.watch(authServiceProvider);
      return LoginController(authService);
    });

final registerControllerProvider =
    StateNotifierProvider<RegisterController, RegisterState>((ref) {
      final authService = ref.watch(authServiceProvider);
      return RegisterController(authService);
    });

final forgotPasswordControllerProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordState>((ref) {
      final authService = ref.watch(authServiceProvider);
      return ForgotPasswordController(authService);
    });
