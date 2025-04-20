import 'package:json_annotation/json_annotation.dart';
import 'test_question.dart';

part 'test.g.dart';

/// Модель теста
@JsonSerializable(explicitToJson: true)
class Test {
  /// Идентификатор теста
  final String id;

  /// Название теста
  final String title;

  /// Описание теста
  final String description;

  /// ID уровня
  final String levelId;

  /// ID связанного видео (если есть)
  final String? videoId;

  /// Проходной балл
  final int passingScore;

  /// Вопросы теста
  final List<TestQuestion> questions;

  Test({
    required this.id,
    required this.title,
    required this.description,
    required this.levelId,
    this.videoId,
    required this.passingScore,
    required this.questions,
  });

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}
