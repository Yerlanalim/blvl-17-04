import '../models/skill.dart';
import '../interfaces/base_repository.dart';

/// Интерфейс репозитория навыков
abstract class SkillRepository extends BaseRepository<Skill> {
  /// Получить навыки по категории
  Future<List<Skill>> getByCategory(String category);
}
