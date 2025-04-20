import 'package:flutter/material.dart';

class VideoErrorDisplay extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const VideoErrorDisplay({
    Key? key,
    required this.errorMessage,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.red, size: 48),
          SizedBox(height: 16),
          Text(errorMessage, style: TextStyle(color: Colors.red)),
          SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: Text('Повторить')),
        ],
      ),
    );
  }
}
