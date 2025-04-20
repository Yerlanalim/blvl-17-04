import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/artifact_repository.dart';
import '../../infrastructure/repositories/firestore_artifact_repository.dart';
import '../../infrastructure/services/cache_manager.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import '../../infrastructure/services/local_storage_service.dart';
import '../services/file_download_service.dart';
import '../services/artifacts_manager.dart';
import '../../domain/services/progress_manager.dart';
import '../../domain/models/artifact.dart';
import '../../domain/models/download_state.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final fileDownloadServiceProvider = Provider<FileDownloadService>((ref) {
  final localStorage = ref.watch(localStorageServiceProvider);
  return FileDownloadService(localStorageService: localStorage);
});

final cacheManagerProvider = Provider<CacheManager>((ref) => CacheManager());

final firestoreDataServiceProvider = Provider<FirestoreDataService>((ref) {
  // Здесь нужно внедрить зависимости Firestore, ErrorHandler, Logger
  throw UnimplementedError(
    'firestoreDataServiceProvider должен быть реализован',
  );
});

final artifactRepositoryProvider = Provider<ArtifactRepository>((ref) {
  final dataService = ref.watch(firestoreDataServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider);
  return FirestoreArtifactRepository(
    dataService: dataService,
    cacheManager: cacheManager,
  );
});

final progressManagerProvider = Provider<ProgressManager>((ref) {
  // Здесь нужно внедрить зависимости FirestoreDataService, ErrorHandler, Logger
  throw UnimplementedError('progressManagerProvider должен быть реализован');
});

final artifactsManagerProvider = Provider<ArtifactsManager>((ref) {
  final artifactRepo = ref.watch(artifactRepositoryProvider);
  final fileDownloadService = ref.watch(fileDownloadServiceProvider);
  final localStorage = ref.watch(localStorageServiceProvider);
  final progressManager = ref.watch(progressManagerProvider);
  return ArtifactsManager(
    artifactRepository: artifactRepo,
    fileDownloadService: fileDownloadService,
    localStorageService: localStorage,
    progressManager: progressManager,
  );
});

/// Провайдер списка артефактов для уровня
final artifactsListProvider = FutureProvider.family<List<Artifact>, String>((
  ref,
  levelId,
) async {
  final manager = ref.watch(artifactsManagerProvider);
  return await manager.getAvailableArtifacts(levelId);
});

/// Провайдер состояния загрузки файла
final downloadStateProvider =
    StreamProvider.family<DownloadState, ({Artifact artifact, String userId})>((
      ref,
      params,
    ) {
      final manager = ref.watch(artifactsManagerProvider);
      return manager.startDownload(params.artifact, params.userId);
    });
