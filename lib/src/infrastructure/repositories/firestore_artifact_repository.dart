import '../../domain/models/artifact.dart';
import '../../domain/repositories/artifact_repository.dart';
import '../services/firestore_data_service.dart';
import '../services/cache_manager.dart';

class FirestoreArtifactRepository implements ArtifactRepository {
  final FirestoreDataService dataService;
  final CacheManager cacheManager;

  FirestoreArtifactRepository({
    required this.dataService,
    required this.cacheManager,
  });

  @override
  Future<Artifact?> getById(String id) async {
    final cacheKey = 'artifact_$id';
    final cached = cacheManager.get<Artifact>(cacheKey);
    if (cached != null) return cached;
    final data = await dataService.read<Artifact>('artifacts', id);
    if (data != null) {
      cacheManager.set(cacheKey, data);
    }
    return data;
  }

  @override
  Future<List<Artifact>> getByLevel(String levelId) async {
    final cacheKey = 'artifacts_level_$levelId';
    final cached = cacheManager.get<List<Artifact>>(cacheKey);
    if (cached != null) return cached;
    final all = await getAll();
    final filtered = all.where((a) => a.levelId == levelId).toList();
    cacheManager.set(cacheKey, filtered);
    return filtered;
  }

  @override
  Future<List<Artifact>> getAll() async {
    final cacheKey = 'artifacts_all';
    final cached = cacheManager.get<List<Artifact>>(cacheKey);
    if (cached != null) return cached;
    final list = await dataService.getList<Artifact>('artifacts');
    cacheManager.set(cacheKey, list);
    return list;
  }

  @override
  Future<Artifact> create(Artifact entity) async {
    await dataService.create('artifacts', entity.toJson());
    cacheManager.invalidate('artifacts_all');
    cacheManager.invalidate('artifacts_level_${entity.levelId}');
    return entity;
  }

  @override
  Future<void> update(String id, Artifact entity) async {
    await dataService.update('artifacts', id, entity.toJson());
    cacheManager.invalidate('artifact_$id');
    cacheManager.invalidate('artifacts_all');
    cacheManager.invalidate('artifacts_level_${entity.levelId}');
  }

  @override
  Future<void> delete(String id) async {
    await dataService.delete('artifacts', id);
    cacheManager.invalidate('artifact_$id');
    cacheManager.invalidate('artifacts_all');
    // Неизвестен levelId, можно сбросить все уровни или реализовать обратную связь
  }
}
