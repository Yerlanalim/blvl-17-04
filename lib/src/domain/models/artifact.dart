import 'package:json_annotation/json_annotation.dart';

part 'artifact.g.dart';

/// Модель артефакта (материала)
@JsonSerializable()
class Artifact {
  /// Идентификатор артефакта
  final String id;

  /// Название артефакта
  final String title;

  /// Описание артефакта
  final String description;

  /// URL файла
  final String fileUrl;

  /// Тип файла (pdf, docx, png и т.д.)
  final String fileType;

  /// ID уровня
  final String levelId;

  Artifact({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.fileType,
    required this.levelId,
  });

  factory Artifact.fromJson(Map<String, dynamic> json) =>
      _$ArtifactFromJson(json);
  Map<String, dynamic> toJson() => _$ArtifactToJson(this);
}
