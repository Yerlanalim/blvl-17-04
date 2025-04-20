import 'package:json_annotation/json_annotation.dart';
import 'package:blvl_17_04_tmp/src/domain/models/business_info.dart';

part 'user_profile.g.dart';

/// Модель профиля пользователя
@JsonSerializable(explicitToJson: true)
class UserProfile {
  /// Имя пользователя
  final String displayName;

  /// URL аватара
  final String? photoUrl;

  /// Информация о бизнесе пользователя
  final BusinessInfo? businessInfo;

  /// Навыки пользователя (skillId -> value)
  final Map<String, int>? skills;

  /// Список достижений (achievementId)
  final List<String>? achievements;

  UserProfile({
    required this.displayName,
    this.photoUrl,
    this.businessInfo,
    this.skills,
    this.achievements,
  });

  /// Десериализация из JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Сериализация в JSON
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
