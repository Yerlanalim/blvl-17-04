import 'package:meta/meta.dart';
import '../../../lib/src/domain/services/skills_manager.dart';

/// Детектор пробелов в навыках пользователя
class SkillGapDetector {
  final ISkillsManager skillsManager;

  SkillGapDetector({required this.skillsManager});

  /// Выявляет пробелы в навыках пользователя (stub: если уровень < 3)
  Future<List<SkillGap>> detect(String userId) async {
    final skills = await skillsManager.getCurrentSkills(userId);
    // Stub: если уровень навыка < 3, считаем пробелом
    final gaps = <SkillGap>[];
    skills.forEach((skillId, level) {
      if (level < 3) {
        gaps.add(
          SkillGap(
            skillId: skillId,
            skillName: skillId, // В реальной логике — получить имя по id
            currentLevel: level,
            requiredLevel: 3,
            description: 'Рекомендуется развить навык до уровня 3',
          ),
        );
      }
    });
    return gaps;
  }
}

/// Пробел в навыке пользователя
class SkillGap {
  final String skillId;
  final String skillName;
  final int currentLevel;
  final int requiredLevel;
  final String description;

  SkillGap({
    required this.skillId,
    required this.skillName,
    required this.currentLevel,
    required this.requiredLevel,
    required this.description,
  });
}
