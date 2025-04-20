import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/error_message.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../providers/auth_form_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final emailController = TextEditingController(text: state.email);
    final passwordController = TextEditingController(text: state.password);

    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Добро пожаловать!',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ErrorMessage(message: state.error!),
                    ),
                  CustomTextField(
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: controller.setEmail,
                    validator: (v) => null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Пароль',
                    controller: passwordController,
                    obscureText: true,
                    onChanged: controller.setPassword,
                    validator: (v) => null,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/forgot-password');
                      },
                      child: const Text('Забыли пароль?'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    label: 'Войти',
                    loading: state.loading,
                    onPressed: state.loading ? null : controller.login,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    label: 'Войти через Google',
                    outlined: true,
                    loading: state.loading,
                    icon: Image.asset('assets/google_logo.png', height: 20),
                    onPressed:
                        state.loading ? null : controller.loginWithGoogle,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Нет аккаунта?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: const Text('Зарегистрироваться'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
