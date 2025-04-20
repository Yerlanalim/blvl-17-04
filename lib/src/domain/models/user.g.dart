// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  email: json['email'] as String,
  profile: UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastLogin:
      json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
  isPremium: json['isPremium'] as bool? ?? false,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'profile': instance.profile.toJson(),
  'createdAt': instance.createdAt.toIso8601String(),
  'lastLogin': instance.lastLogin?.toIso8601String(),
  'isPremium': instance.isPremium,
};
