import '../../domain/models/artifact.dart';
import '../../domain/models/download_state.dart';
import '../../domain/repositories/artifact_repository.dart';
import '../../infrastructure/services/local_storage_service.dart';
import 'file_download_service.dart';
import '../../domain/services/progress_manager.dart';
import '../../domain/models/progress.dart';

class ArtifactsManager {
  final ArtifactRepository artifactRepository;
  final FileDownloadService fileDownloadService;
  final LocalStorageService localStorageService;
  final ProgressManager progressManager;

  ArtifactsManager({
    required this.artifactRepository,
    required this.fileDownloadService,
    required this.localStorageService,
    required this.progressManager,
  });

  /// Получить список артефактов для уровня
  Future<List<Artifact>> getAvailableArtifacts(String levelId) async {
    return await artifactRepository.getByLevel(levelId);
  }

  /// Запустить загрузку артефакта
  Stream<DownloadState> startDownload(Artifact artifact, String userId) async* {
    final stream = fileDownloadService.downloadFile(
      artifact.fileUrl,
      artifact.id,
    );
    await for (final state in stream) {
      if (state.status == DownloadStatus.completed) {
        // Получаем текущий прогресс по уровню
        final userProgress = await progressManager.getUserProgress(userId);
        final currentLevelProgress =
            userProgress.levelProgress[artifact.levelId];
        final artifactsDownloaded = List<String>.from(
          currentLevelProgress?.artifactsDownloaded ?? [],
        );
        if (!artifactsDownloaded.contains(artifact.id)) {
          artifactsDownloaded.add(artifact.id);
        }
        final updatedLevelProgress = LevelProgress(
          videosWatched: currentLevelProgress?.videosWatched ?? [],
          testsCompleted: currentLevelProgress?.testsCompleted ?? {},
          artifactsDownloaded: artifactsDownloaded,
          startedAt: currentLevelProgress?.startedAt,
          completedAt: currentLevelProgress?.completedAt,
          progressPercentage: currentLevelProgress?.progressPercentage ?? 0.0,
        );
        await progressManager.updateLevelProgress(
          userId,
          artifact.levelId,
          updatedLevelProgress,
        );
      }
      yield state;
    }
  }

  /// Получить состояние загрузки
  DownloadState? getDownloadState(String fileName) {
    return fileDownloadService.getDownloadState(fileName);
  }

  /// Открыть локальный файл (возвращает путь)
  Future<String?> openArtifact(String fileName) async {
    final file = await localStorageService.getFile(fileName);
    return file?.path;
  }

  /// Удалить локальный файл
  Future<void> removeArtifact(String fileName) async {
    await localStorageService.deleteFile(fileName);
  }
}
