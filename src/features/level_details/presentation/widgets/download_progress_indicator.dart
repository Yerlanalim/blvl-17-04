import 'package:flutter/material.dart';

class DownloadProgressIndicator extends StatelessWidget {
  final double progress;
  const DownloadProgressIndicator({Key? key, required this.progress})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Реализовать индикатор прогресса загрузки
    return LinearProgressIndicator(value: progress);
  }
}
