// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
  category: json['category'] as String,
);

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'icon': instance.icon,
  'category': instance.category,
};
