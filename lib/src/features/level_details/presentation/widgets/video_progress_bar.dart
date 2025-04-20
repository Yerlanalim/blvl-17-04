import 'package:flutter/material.dart';

class VideoProgressBar extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  const VideoProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: progress);
  }
}
