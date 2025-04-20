import 'package:flutter/material.dart';
import '../../../../../lib/src/domain/models/download_state.dart';

class DownloadStatusBadge extends StatelessWidget {
  final DownloadStatus status;
  const DownloadStatusBadge({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (status) {
      case DownloadStatus.notStarted:
        color = Colors.grey;
        label = 'Доступно';
        break;
      case DownloadStatus.inProgress:
        color = Colors.blue;
        label = 'Скачивается';
        break;
      case DownloadStatus.completed:
        color = Colors.green;
        label = 'Скачано';
        break;
      case DownloadStatus.failed:
        color = Colors.red;
        label = 'Ошибка';
        break;
      case DownloadStatus.canceled:
        color = Colors.orange;
        label = 'Отменено';
        break;
    }
    return Chip(
      label: Text(label, style: TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
