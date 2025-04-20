import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../lib/src/domain/models/artifact.dart';
import '../../../../../lib/src/application/services/artifacts_manager.dart';
import '../../../../../lib/src/application/providers/artifact_providers.dart';

// TODO: Реализовать провайдеры для управления состоянием UI артефактов

// Провайдер списка артефактов для уровня (уже реализован в artifact_providers.dart)
// final artifactsListProvider = ...

// Провайдер скачанных артефактов для конкретного уровня (userId, levelId)
final downloadedArtifactsProvider =
    FutureProvider.family<List<Artifact>, ({String userId, String levelId})>((
      ref,
      params,
    ) async {
      final manager = ref.watch(artifactsManagerProvider);
      final artifacts = await ref.watch(
        artifactsListProvider(params.levelId).future,
      );
      final result = <Artifact>[];
      for (final artifact in artifacts) {
        final hasFile = await manager.localStorageService.hasFile(artifact.id);
        if (hasFile) result.add(artifact);
      }
      return result;
    });
// Для получения всех скачанных артефактов по всем уровням потребуется отдельный провайдер, агрегирующий все артефакты пользователя.

// Провайдер фильтрации/поиска/сортировки
final artifactFilterProvider = StateProvider<String>((ref) => '');
final artifactSortProvider = StateProvider<String>(
  (ref) => 'title',
); // или 'date', 'type' и т.д.

// Провайдер избранного (id артефактов)
final favoriteArtifactsProvider =
    StateNotifierProvider<FavoriteArtifactsNotifier, Set<String>>(
      (ref) => FavoriteArtifactsNotifier(),
    );

class FavoriteArtifactsNotifier extends StateNotifier<Set<String>> {
  FavoriteArtifactsNotifier() : super(<String>{});

  void toggleFavorite(String artifactId) {
    if (state.contains(artifactId)) {
      state = {...state}..remove(artifactId);
    } else {
      state = {...state, artifactId};
    }
  }
}

// Провайдер состояния удаления
final artifactDeleteStateProvider = StateProvider<String?>(
  (ref) => null,
); // id удаляемого артефакта
