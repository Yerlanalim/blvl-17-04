import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/error_message.dart';
import '../providers/auth_form_providers.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    final emailController = TextEditingController(text: state.email);
    final passwordController = TextEditingController(text: state.password);
    final confirmController = TextEditingController(
      text: state.confirmPassword,
    );
    final nameController = TextEditingController(text: state.name);

    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
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
                    'Создайте аккаунт',
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
                    label: 'Имя',
                    controller: nameController,
                    onChanged: controller.setName,
                    validator: (v) => null,
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Повторите пароль',
                    controller: confirmController,
                    obscureText: true,
                    onChanged: controller.setConfirmPassword,
                    validator: (v) => null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: agree,
                        onChanged: (v) => setState(() => agree = v ?? false),
                      ),
                      const Expanded(
                        child: Text(
                          'Я принимаю условия использования',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    label: 'Зарегистрироваться',
                    loading: state.loading,
                    enabled: agree && !state.loading,
                    onPressed:
                        agree && !state.loading ? controller.register : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Уже есть аккаунт?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: const Text('Войти'),
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
