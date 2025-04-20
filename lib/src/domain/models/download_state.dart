enum DownloadStatus { notStarted, inProgress, completed, failed, canceled }

class DownloadState {
  final String fileName;
  final DownloadStatus status;
  final double progress; // 0.0 - 1.0
  final String? error;

  DownloadState({
    required this.fileName,
    required this.status,
    this.progress = 0.0,
    this.error,
  });

  DownloadState copyWith({
    DownloadStatus? status,
    double? progress,
    String? error,
  }) {
    return DownloadState(
      fileName: fileName,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      error: error ?? this.error,
    );
  }
}
