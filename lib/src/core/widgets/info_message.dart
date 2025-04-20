import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class InfoMessage extends StatelessWidget {
  final String message;
  final EdgeInsetsGeometry? padding;
  final bool dense;
  final IconData? icon;
  final Color? color;

  const InfoMessage({
    super.key,
    required this.message,
    this.padding,
    this.dense = false,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final infoColor = color ?? AppColors.info;
    return Container(
      width: double.infinity,
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: infoColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: infoColor.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.info_outline,
            color: infoColor,
            size: dense ? 18 : 22,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: infoColor,
                fontSize: dense ? 13 : 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
