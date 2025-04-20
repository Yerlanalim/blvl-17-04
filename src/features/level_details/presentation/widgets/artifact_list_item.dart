import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../lib/src/domain/models/artifact.dart';
import '../../../../../lib/src/application/services/artifacts_manager.dart';
import '../widgets/artifact_type_icon.dart';
import '../widgets/download_button.dart';
import '../widgets/download_status_badge.dart';
import '../providers/artifacts_ui_providers.dart';
import '../../../../../lib/src/application/providers/artifact_providers.dart';
import '../../../../../lib/src/domain/models/download_state.dart';
import '../screens/artifact_viewer_screen.dart';
import '../screens/artifact_details_screen.dart';

class ArtifactListItem extends ConsumerWidget {
  final Artifact artifact;
  final bool showDelete;
  const ArtifactListItem({
    Key? key,
    required this.artifact,
    this.showDelete = false,
  }) : super(key: key);

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
    return ListTile(
      leading: ArtifactTypeIcon(fileType: artifact.fileType),
      title: Text(artifact.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(artifact.description),
          if (showDelete)
            FutureBuilder<int>(
              future: manager.localStorageService.getFileSize(artifact.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Размер: ...');
                }
                final size = snapshot.data ?? 0;
                return Text('Размер: ${(size / 1024).toStringAsFixed(1)} КБ');
              },
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          if (showDelete)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Удалить файл',
              onPressed: () async {
                await manager.removeArtifact(artifact.id);
                ref.invalidate(downloadedArtifactsProvider);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Файл удалён')));
              },
            ),
          if (!showDelete)
            DownloadButton(
              onPressed: () {
                ref.refresh(
                  downloadStateProvider((artifact: artifact, userId: userId)),
                );
                // Показываем SnackBar при завершении загрузки
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
          const SizedBox(width: 8),
          DownloadStatusBadge(status: status),
        ],
      ),
      onTap: () {
        // Переход к деталям артефакта
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ArtifactDetailsScreen(artifact: artifact),
          ),
        );
      },
    );
  }
}
