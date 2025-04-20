import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../lib/src/domain/models/artifact.dart';
import '../../../../../lib/src/domain/models/download_state.dart';
import '../../../../../lib/src/application/providers/artifact_providers.dart';
import '../widgets/artifact_type_icon.dart';
import '../widgets/download_button.dart';
import '../widgets/download_status_badge.dart';
import '../widgets/file_preview_widget.dart';
import '../providers/artifacts_ui_providers.dart';
import 'artifact_viewer_screen.dart';

class ArtifactDetailsScreen extends ConsumerWidget {
  final Artifact artifact;
  const ArtifactDetailsScreen({Key? key, required this.artifact})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteArtifactsProvider);
    final isFavorite = favorites.contains(artifact.id);
    final manager = ref.read(artifactsManagerProvider);
    final userId = 'demoUser'; // TODO: заменить на реальный userId из auth
    final downloadStateAsync = ref.watch(
      downloadStateProvider((artifact: artifact, userId: userId)),
    );
    DownloadStatus status = DownloadStatus.notStarted;
    double progress = 0.0;
    bool isLoading = false;
    String? errorMessage;
    if (downloadStateAsync.asData != null) {
      final state = downloadStateAsync.asData!.value;
      status = state.status;
      progress = state.progress;
      errorMessage = state.error;
      isLoading = status == DownloadStatus.inProgress;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(artifact.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : null,
            ),
            onPressed:
                () => ref
                    .read(favoriteArtifactsProvider.notifier)
                    .toggleFavorite(artifact.id),
            tooltip: isFavorite ? 'Убрать из избранного' : 'В избранное',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ArtifactTypeIcon(fileType: artifact.fileType),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    artifact.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                DownloadStatusBadge(status: status),
              ],
            ),
            const SizedBox(height: 16),
            Text(artifact.description),
            const SizedBox(height: 24),
            DownloadButton(
              onPressed: () {
                ref.refresh(
                  downloadStateProvider((artifact: artifact, userId: userId)),
                );
                ref.listen<AsyncValue<DownloadState>>(
                  downloadStateProvider((artifact: artifact, userId: userId)),
                  (prev, next) {
                    if (next.asData?.value.status == DownloadStatus.completed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Файл скачан')),
                      );
                    }
                  },
                );
              },
              isLoading: isLoading,
              progress: progress,
              state:
                  status == DownloadStatus.inProgress
                      ? DownloadButtonState.inProgress
                      : status == DownloadStatus.completed
                      ? DownloadButtonState.completed
                      : status == DownloadStatus.failed
                      ? DownloadButtonState.error
                      : DownloadButtonState.idle,
              errorMessage: errorMessage,
              onOpen:
                  status == DownloadStatus.completed
                      ? () async {
                        final filePath = await manager.openArtifact(
                          artifact.id,
                        );
                        if (filePath != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => ArtifactViewerScreen(
                                    filePath: filePath,
                                    fileType: artifact.fileType,
                                  ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Файл не найден')),
                          );
                        }
                      }
                      : null,
            ),
            const SizedBox(height: 24),
            Text('Предпросмотр:'),
            const SizedBox(height: 8),
            Expanded(
              child:
                  status == DownloadStatus.completed
                      ? FutureBuilder<String?>(
                        future: manager.openArtifact(artifact.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final filePath = snapshot.data;
                          if (filePath != null) {
                            return FilePreviewWidget(
                              filePath: filePath,
                              fileType: artifact.fileType,
                            );
                          } else {
                            return const Center(child: Text('Файл не найден'));
                          }
                        },
                      )
                      : const Center(
                        child: Text('Скачайте файл для предпросмотра'),
                      ), // если не скачан
            ),
          ],
        ),
      ),
    );
  }
}
