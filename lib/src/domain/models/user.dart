import 'package:json_annotation/json_annotation.dart';
import 'user_profile.dart';

part 'user.g.dart';

/// Модель пользователя
@JsonSerializable(explicitToJson: true)
class User {
  /// Идентификатор пользователя
  final String id;

  /// Email пользователя
  final String email;

  /// Профиль пользователя
  final UserProfile profile;

  /// Дата создания аккаунта (timestamp)
  final DateTime createdAt;

  /// Дата последнего входа (timestamp)
  final DateTime? lastLogin;

  /// Признак премиум-статуса
  final bool isPremium;

  User({
    required this.id,
    required this.email,
    required this.profile,
    required this.createdAt,
    this.lastLogin,
    this.isPremium = false,
  });

  /// Десериализация из JSON
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Сериализация в JSON
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    UserProfile? profile,
    DateTime? createdAt,
    DateTime? lastLogin,
    bool? isPremium,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      isPremium: isPremium ?? this.isPremium,
    );
  }
}
