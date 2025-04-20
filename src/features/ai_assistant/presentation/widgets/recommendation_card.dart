import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const RecommendationCard({
    Key? key,
    required this.title,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(description),
        trailing: onTap != null ? Icon(Icons.arrow_forward) : null,
        onTap: onTap,
      ),
    );
  }
}
