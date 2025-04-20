import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/providers/theme_provider.dart';
import '../constants/strings.dart';

class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.light_mode,
          color:
              mode == ThemeMode.light
                  ? Theme.of(context).colorScheme.primary
                  : null,
        ),
        Switch(
          value: mode == ThemeMode.dark,
          onChanged: (val) => ref.read(themeProvider.notifier).toggleTheme(),
        ),
        Icon(
          Icons.dark_mode,
          color:
              mode == ThemeMode.dark
                  ? Theme.of(context).colorScheme.primary
                  : null,
        ),
      ],
    );
  }
}
