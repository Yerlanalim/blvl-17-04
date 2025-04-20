// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artifact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artifact _$ArtifactFromJson(Map<String, dynamic> json) => Artifact(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  fileUrl: json['fileUrl'] as String,
  fileType: json['fileType'] as String,
  levelId: json['levelId'] as String,
);

Map<String, dynamic> _$ArtifactToJson(Artifact instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'fileUrl': instance.fileUrl,
  'fileType': instance.fileType,
  'levelId': instance.levelId,
};
