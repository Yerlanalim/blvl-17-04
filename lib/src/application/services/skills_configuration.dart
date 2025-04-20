/// Конфигурация системы навыков: типы, коэффициенты, лимиты, правила
class SkillsConfiguration {
  /// Список поддерживаемых навыков (skillId -> displayName)
  static const Map<String, String> skillTypes = {
    'personal': 'Личные навыки',
    'management': 'Менеджмент',
    'marketing': 'Маркетинг',
    'finance': 'Финансы',
    // Добавить другие навыки по мере необходимости
  };

  /// Максимальный уровень для каждого навыка
  static const int maxSkillLevel = 100;

  /// Коэффициенты прироста для разных типов навыков
  static const Map<String, double> growthCoefficients = {
    'personal': 1.0,
    'management': 1.2,
    'marketing': 0.9,
    'finance': 1.1,
  };

  /// Получить displayName по skillId
  static String getSkillName(String skillId) => skillTypes[skillId] ?? skillId;
}
