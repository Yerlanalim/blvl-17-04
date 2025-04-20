// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  displayName: json['displayName'] as String,
  photoUrl: json['photoUrl'] as String?,
  businessInfo: json['businessInfo'] as Map<String, dynamic>?,
  skills: (json['skills'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
  achievements:
      (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'businessInfo': instance.businessInfo,
      'skills': instance.skills,
      'achievements': instance.achievements,
    };
