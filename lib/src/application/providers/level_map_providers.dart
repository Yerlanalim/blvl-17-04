import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/level_map_manager.dart';
import '../services/level_map_cache.dart';
import '../../infrastructure/services/cache_manager.dart';
import '../../infrastructure/repositories/firestore_level_repository.dart';
import '../models/level_graph.dart';
import '../../domain/models/level.dart';

/// Провайдер кэш-менеджера
final cacheManagerProvider = Provider<CacheManager>((ref) => CacheManager());

/// Провайдер кэша карты уровней
final levelMapCacheProvider = Provider<LevelMapCache>(
  (ref) => LevelMapCache(ref.read(cacheManagerProvider)),
);

/// Провайдер репозитория уровней
final levelRepositoryProvider = Provider<FirestoreLevelRepository>(
  (ref) => FirestoreLevelRepository(
    dataService: /* TODO: внедрить FirestoreDataService */
        throw UnimplementedError(),
    cacheManager: ref.read(cacheManagerProvider),
    errorHandler: /* TODO: внедрить ErrorHandler */ throw UnimplementedError(),
  ),
);

/// Провайдер менеджера карты уровней
final levelMapManagerProvider = Provider<LevelMapManager>(
  (ref) => LevelMapManager(
    levelRepository: ref.read(levelRepositoryProvider),
    cache: ref.read(levelMapCacheProvider),
  ),
);

/// Провайдер графа уровней
final levelGraphProvider = FutureProvider<LevelGraph>((ref) async {
  final manager = ref.read(levelMapManagerProvider);
  return await manager.getGraph();
});

/// Провайдер видимых уровней (пагинация)
final visibleLevelsProvider = FutureProvider.family<List<Level>, int>((
  ref,
  page,
) async {
  final manager = ref.read(levelMapManagerProvider);
  return await manager.getVisibleLevels(page: page);
});

/// Провайдер доступных уровней для пользователя
final availableLevelsProvider = FutureProvider<List<Level>>((ref) async {
  final manager = ref.read(levelMapManagerProvider);
  return await manager.getAvailableLevels();
});
