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
