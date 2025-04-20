import '../models/artifact.dart';
import '../interfaces/base_repository.dart';

/// Интерфейс репозитория артефактов
abstract class ArtifactRepository extends BaseRepository<Artifact> {
  /// Получить артефакты по уровню
  Future<List<Artifact>> getByLevel(String levelId);
}
