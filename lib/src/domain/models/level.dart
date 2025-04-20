import 'package:json_annotation/json_annotation.dart';

part 'level.g.dart';

/// Модель уровня обучения
@JsonSerializable(explicitToJson: true)
class Level {
  /// Идентификатор уровня
  final String id;

  /// Название уровня
  final String title;

  /// Описание уровня
  final String description;

  /// Порядковый номер уровня
  final int order;

  /// Признак премиум-уровня
  final bool isPremium;

  /// ID следующего уровня
  final String? nextLevelId;

  /// Содержимое уровня (видео, тесты, артефакты)
  final LevelContents contents;

  /// Навыки, получаемые за уровень (skillId -> value)
  final Map<String, int>? skillsGained;

  Level({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.isPremium,
    this.nextLevelId,
    required this.contents,
    this.skillsGained,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelToJson(this);
}

/// Содержимое уровня: ссылки на видео, тесты, артефакты
@JsonSerializable()
class LevelContents {
  final List<String> videoIds;
  final List<String> testIds;
  final List<String> artifactIds;

  LevelContents({
    required this.videoIds,
    required this.testIds,
    required this.artifactIds,
  });

  factory LevelContents.fromJson(Map<String, dynamic> json) =>
      _$LevelContentsFromJson(json);
  Map<String, dynamic> toJson() => _$LevelContentsToJson(this);
}
