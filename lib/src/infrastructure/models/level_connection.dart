import 'package:json_annotation/json_annotation.dart';

part 'level_connection.g.dart';

/// Модель связи между уровнями (level_connections)
@JsonSerializable()
class LevelConnection {
  final String id;
  final String sourceLevelId;
  final String targetLevelId;
  final String direction;

  LevelConnection({
    required this.id,
    required this.sourceLevelId,
    required this.targetLevelId,
    required this.direction,
  });

  factory LevelConnection.fromJson(Map<String, dynamic> json) =>
      _$LevelConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$LevelConnectionToJson(this);
}
