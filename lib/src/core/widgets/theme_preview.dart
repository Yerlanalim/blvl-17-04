import 'package:flutter/material.dart';
import '../constants/strings.dart';
import 'theme_toggle.dart';

class ThemePreview extends StatelessWidget {
  const ThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            const ThemeToggle(),
            const SizedBox(height: 24),
            Text(
              AppStrings.welcome,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text(AppStrings.signIn)),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: () {}, child: Text(AppStrings.signUp)),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: Text(AppStrings.forgotPassword),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.email,
                hintText: 'example@email.com',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.password,
                hintText: '******',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
