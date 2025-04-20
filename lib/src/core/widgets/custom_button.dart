import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/button_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final bool outlined;
  final Widget? icon;
  final ButtonStyle? style;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.outlined = false,
    this.icon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final btnStyle =
        style ??
        (outlined
            ? (theme.brightness == Brightness.dark
                ? AppButtonThemes.outlinedDark
                : AppButtonThemes.outlinedLight)
            : (theme.brightness == Brightness.dark
                ? AppButtonThemes.elevatedDark
                : AppButtonThemes.elevatedLight));
    return SizedBox(
      width: double.infinity,
      child:
          outlined
              ? OutlinedButton(
                onPressed: enabled && !loading ? onPressed : null,
                style: btnStyle,
                child: _buildChild(),
              )
              : ElevatedButton(
                onPressed: enabled && !loading ? onPressed : null,
                style: btnStyle,
                child: _buildChild(),
              ),
    );
  }

  Widget _buildChild() {
    if (loading) {
      return const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.onPrimary),
        ),
      );
    }
    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [icon!, const SizedBox(width: 8), Text(label)],
      );
    }
    return Text(label);
  }
}
