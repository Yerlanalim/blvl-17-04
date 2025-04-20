import '../models/level.dart';
import '../interfaces/base_repository.dart';

/// Интерфейс репозитория уровней
abstract class LevelRepository extends BaseRepository<Level> {
  /// Получить уровни по признаку премиум
  Future<List<Level>> getByPremium(bool isPremium);

  /// Получить следующий уровень по id
  Future<Level?> getNextLevel(String currentLevelId);
}
