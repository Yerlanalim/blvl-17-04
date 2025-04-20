import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:blvl_17_04_tmp/src/application/services/level_map_manager.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/repositories/firestore_level_repository.dart';
import 'package:blvl_17_04_tmp/src/application/services/level_map_cache.dart';
import 'package:blvl_17_04_tmp/src/domain/models/progress.dart';

class MockLevelRepository extends Mock implements FirestoreLevelRepository {}

class MockLevelMapCache extends Mock implements LevelMapCache {}

void main() {
  late LevelMapManager manager;
  late MockLevelRepository levelRepository;
  late MockLevelMapCache cache;

  setUp(() {
    levelRepository = MockLevelRepository();
    cache = MockLevelMapCache();
    manager = LevelMapManager(levelRepository: levelRepository, cache: cache);
  });

  group('getAllLevels', () {
    test('returns levels from cache if present', () async {
      // TODO: реализовать
    });
    test('fetches from repository if cache is empty', () async {
      // TODO: реализовать
    });
  });

  group('getLevelConnections', () {
    test('returns connections from cache if present', () async {
      // TODO: реализовать
    });
    test('fetches from repository if cache is empty', () async {
      // TODO: реализовать
    });
  });

  group('getAvailableLevels', () {
    test('returns available levels for user progress', () async {
      // TODO: реализовать
    });
  });

  group('getLockedLevels', () {
    test('returns locked levels for user progress', () async {
      // TODO: реализовать
    });
  });
}
