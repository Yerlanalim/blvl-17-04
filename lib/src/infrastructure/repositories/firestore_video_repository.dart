import '../../domain/repositories/video_repository.dart';
import '../../domain/models/video.dart';
import '../services/firestore_data_service.dart';
import '../services/cache_manager.dart';

class FirestoreVideoRepository implements VideoRepository {
  final FirestoreDataService dataService;
  final CacheManager cacheManager;

  FirestoreVideoRepository({
    required this.dataService,
    required this.cacheManager,
  });

  static const String collection = 'videos';

  @override
  Future<Video?> getById(String id) async {
    final cacheKey = 'video_$id';
    final cached = cacheManager.get<Video>(cacheKey);
    if (cached != null) return cached;
    final video = await dataService.read<Video>(collection, id);
    if (video != null) cacheManager.set<Video>(cacheKey, video);
    return video;
  }

  @override
  Future<List<Video>> getByLevel(String levelId) async {
    final cacheKey = 'videos_level_$levelId';
    final cached = cacheManager.get<List<Video>>(cacheKey);
    if (cached != null) return cached;
    // Предполагается, что getList поддерживает фильтрацию по levelId
    final all = await dataService.getList<Video>(collection);
    final filtered = all.where((v) => v.levelId == levelId).toList();
    cacheManager.set<List<Video>>(cacheKey, filtered);
    return filtered;
  }

  @override
  Future<List<Video>> getAll() async {
    final cacheKey = 'videos_all';
    final cached = cacheManager.get<List<Video>>(cacheKey);
    if (cached != null) return cached;
    final all = await dataService.getList<Video>(collection);
    cacheManager.set<List<Video>>(cacheKey, all);
    return all;
  }

  @override
  Future<Video> create(Video entity) async {
    final created = await dataService.create<Video>(
      collection,
      entity.toJson(),
    );
    cacheManager.invalidate('videos_all');
    cacheManager.invalidate('videos_level_${entity.levelId}');
    return created;
  }

  @override
  Future<void> update(String id, Video entity) async {
    await dataService.update(collection, id, entity.toJson());
    cacheManager.invalidate('video_$id');
    cacheManager.invalidate('videos_all');
    cacheManager.invalidate('videos_level_${entity.levelId}');
  }

  @override
  Future<void> delete(String id) async {
    await dataService.delete(collection, id);
    cacheManager.invalidate('video_$id');
    cacheManager.invalidate('videos_all');
    // Для корректности желательно также инвалидировать все videos_level_*
  }
}
