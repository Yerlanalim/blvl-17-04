import '../models/skill.dart';

/// Интерфейс для управления навыками пользователя
abstract class ISkillsManager {
  /// Получить текущие навыки пользователя (skillId -> value)
  Future<Map<String, int>> getCurrentSkills(String userId);

  /// Повысить навыки пользователя на заданные значения (skillId -> delta)
  Future<void> increaseSkills(String userId, Map<String, int> skillsDelta);

  /// Получить общий уровень навыков пользователя (например, сумма или агрегированное значение)
  Future<int> getTotalSkillLevel(String userId);

  /// Получить подробную статистику по навыкам (например, для визуализации)
  Future<Map<String, dynamic>> getSkillsStats(String userId);

  /// Получить рекомендации по развитию навыков
  Future<List<String>> getSkillRecommendations(String userId);

  /// Получить историю изменений навыков (опционально)
  Future<List<Map<String, dynamic>>> getSkillsHistory(String userId);
}
