import 'package:flutter/material.dart';

/// Виджет для отображения рекомендаций и объяснений после теста
class FeedbackWidget extends StatelessWidget {
  final String feedbackText;

  const FeedbackWidget({super.key, required this.feedbackText});

  @override
  Widget build(BuildContext context) {
    // TODO: реализовать UI для отображения рекомендаций и объяснений
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(feedbackText, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
