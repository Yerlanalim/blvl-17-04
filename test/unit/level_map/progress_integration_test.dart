import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:blvl_17_04_tmp/src/application/services/progress_level_map_integrator.dart';
import 'package:blvl_17_04_tmp/src/application/services/level_map_manager.dart';
import 'package:blvl_17_04_tmp/src/domain/services/progress_manager.dart';
import 'package:blvl_17_04_tmp/src/domain/models/progress.dart';
import 'package:blvl_17_04_tmp/src/domain/models/level.dart';
import 'package:blvl_17_04_tmp/src/application/services/level_map_cache.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/repositories/firestore_level_repository.dart';

class MockFirestoreLevelRepository extends Mock
    implements FirestoreLevelRepository {}

class MockLevelMapCache extends Mock implements LevelMapCache {}

class TestProgressManager implements ProgressManager {
  @override
  Future<Progress> getUserProgress(String userId) => throw UnimplementedError();
  @override
  Future<void> updateLevelProgress(
    String userId,
    String levelId,
    LevelProgress progress,
  ) => throw UnimplementedError();
  @override
  Future<void> resetProgress(String userId) => throw UnimplementedError();
}

void main() {
  late ProgressLevelMapIntegrator integrator;
  late TestProgressManager progressManager;
  late LevelMapManager levelMapManager;
  late MockFirestoreLevelRepository mockRepo;
  late MockLevelMapCache mockCache;

  setUp(() {
    mockRepo = MockFirestoreLevelRepository();
    mockCache = MockLevelMapCache();
    progressManager = TestProgressManager();
    levelMapManager = LevelMapManager.forTest(
      levelRepository: mockRepo,
      cache: mockCache,
    );
    integrator = ProgressLevelMapIntegrator(
      progressManager: progressManager,
      levelMapManager: levelMapManager,
    );
  });

  group('ProgressLevelMapIntegrator', () {
    test('emits correct events on level unlock', () async {
      // TODO: реализовать
    });
    test('emits correct events on achievement unlock', () async {
      // TODO: реализовать
    });
    test('integrates progress and map correctly', () async {
      // TODO: реализовать
    });
  });
}
