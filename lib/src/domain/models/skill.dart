import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

/// Модель навыка пользователя
@JsonSerializable()
class Skill {
  /// Идентификатор навыка
  final String id;

  /// Название навыка
  final String name;

  /// Описание навыка
  final String description;

  /// Иконка навыка (путь к ресурсу)
  final String icon;

  /// Категория навыка
  final String category;

  Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);
}
