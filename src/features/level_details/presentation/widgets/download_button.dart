import 'package:flutter/material.dart';

enum DownloadButtonState { idle, loading, inProgress, completed, error }

class DownloadButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onCancel;
  final VoidCallback? onOpen;
  final bool isLoading;
  final double? progress;
  final DownloadButtonState state;
  final String? errorMessage;
  const DownloadButton({
    Key? key,
    this.onPressed,
    this.onCancel,
    this.onOpen,
    this.isLoading = false,
    this.progress,
    this.state = DownloadButtonState.idle,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case DownloadButtonState.loading:
        return ElevatedButton(
          onPressed: null,
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      case DownloadButtonState.inProgress:
        return ElevatedButton.icon(
          onPressed: onCancel,
          icon: const Icon(Icons.close),
          label: SizedBox(
            width: 80,
            child: LinearProgressIndicator(value: progress ?? 0),
          ),
        );
      case DownloadButtonState.completed:
        return ElevatedButton.icon(
          onPressed: onOpen,
          icon: const Icon(Icons.open_in_new),
          label: const Text('Открыть'),
        );
      case DownloadButtonState.error:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.refresh),
          label: Text(errorMessage ?? 'Ошибка'),
        );
      case DownloadButtonState.idle:
      default:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.download),
          label: const Text('Скачать'),
        );
    }
  }
}
