import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

/// Модель видеоурока
@JsonSerializable()
class Video {
  /// Идентификатор видео
  final String id;

  /// Название видео
  final String title;

  /// Описание видео
  final String description;

  /// YouTube ID
  final String youtubeId;

  /// ID уровня, к которому относится видео
  final String levelId;

  /// Порядковый номер в уровне
  final int order;

  /// Длительность видео (секунды)
  final int duration;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeId,
    required this.levelId,
    required this.order,
    required this.duration,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
