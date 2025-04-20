import 'package:flutter/material.dart';

class VideoCompletionNotification extends StatelessWidget {
  final VoidCallback onNext;
  const VideoCompletionNotification({Key? key, required this.onNext})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 48),
          SizedBox(height: 16),
          Text('Просмотр завершён!', style: TextStyle(color: Colors.green)),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onNext,
            child: Text('К следующему материалу'),
          ),
        ],
      ),
    );
  }
}
