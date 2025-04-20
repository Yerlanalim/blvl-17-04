import 'package:json_annotation/json_annotation.dart';

part 'business_info.g.dart';

/// Модель информации о бизнесе пользователя
@JsonSerializable()
class BusinessInfo {
  /// Название компании
  final String companyName;

  /// Сфера деятельности
  final String industry;

  /// Размер компании (например, число сотрудников)
  final int? companySize;

  /// Город или регион
  final String? location;

  /// Дополнительная информация
  final String? description;

  BusinessInfo({
    required this.companyName,
    required this.industry,
    this.companySize,
    this.location,
    this.description,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) =>
      _$BusinessInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessInfoToJson(this);
}
