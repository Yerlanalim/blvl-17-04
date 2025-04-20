import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/repositories/firestore_level_repository.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/firestore_data_service.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/cache_manager.dart';
import 'package:blvl_17_04_tmp/src/core/utils/error_handler.dart';
import 'package:blvl_17_04_tmp/src/domain/models/level.dart';

class MockFirestoreDataService extends Mock implements FirestoreDataService {}

class MockCacheManager extends Mock implements CacheManager {}

class MockErrorHandler extends Mock implements ErrorHandler {}

void main() {
  late FirestoreLevelRepository repository;
  late MockFirestoreDataService dataService;
  late MockCacheManager cacheManager;
  late MockErrorHandler errorHandler;

  setUp(() {
    dataService = MockFirestoreDataService();
    cacheManager = MockCacheManager();
    errorHandler = MockErrorHandler();
    repository = FirestoreLevelRepository(
      dataService: dataService,
      cacheManager: cacheManager,
      errorHandler: errorHandler,
    );
  });

  group('getAll', () {
    test('returns levels from cache if not expired', () async {
      final levels = [
        Level(
          id: '1',
          title: 'Level 1',
          description: '',
          order: 1,
          isPremium: false,
          contents: LevelContents(videoIds: [], testIds: [], artifactIds: []),
        ),
      ];
      when(
        () => cacheManager.get<List<Level>>('levels_all'),
      ).thenReturn(levels);
      when(() => cacheManager.isExpired('levels_all')).thenReturn(false);

      final result = await repository.getAll();
      expect(result, equals(levels));
      verifyNever(() => dataService.getList<Level>('levels'));
    });
    test('fetches from Firestore if cache is empty', () async {
      // TODO: реализовать
    });
    test('returns cached on error', () async {
      // TODO: реализовать
    });
  });

  group('getByPremium', () {
    test('filters levels by premium flag', () async {
      // TODO: реализовать
    });
  });

  group('getNextLevel', () {
    test('returns next level if exists', () async {
      // TODO: реализовать
    });
    test('returns null if no next level', () async {
      // TODO: реализовать
    });
  });

  group('pagination', () {
    test('returns paginated levels', () async {
      // TODO: реализовать
    });
  });

  group('cache invalidation', () {
    test('invalidates all relevant cache keys', () {
      // TODO: реализовать
    });
  });
}
