import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

/// Модель достижения пользователя
@JsonSerializable()
class Achievement {
  /// Идентификатор достижения
  final String id;

  /// Название достижения
  final String title;

  /// Описание достижения
  final String description;

  /// Иконка достижения (путь к ресурсу)
  final String icon;

  /// Критерии получения достижения (описание)
  final String criteria;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.criteria,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);
}

/// Статус достижения
enum AchievementStatus { unlocked, inProgress, locked }

/// Прогресс по достижению
class AchievementProgress {
  final String achievementId;
  final double percent; // 0.0 - 1.0
  final AchievementStatus status;

  AchievementProgress({
    required this.achievementId,
    required this.percent,
    required this.status,
  });
}

/// Событие, связанное с достижением
class AchievementEvent {
  final String type;
  final Map<String, dynamic> payload;

  AchievementEvent({required this.type, required this.payload});
}
