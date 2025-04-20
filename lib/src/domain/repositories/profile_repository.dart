import 'package:blvl_17_04_tmp/src/domain/models/user_profile.dart';
import 'package:blvl_17_04_tmp/src/domain/models/business_info.dart';

abstract class IProfileRepository {
  /// Получить профиль пользователя по userId
  Future<UserProfile?> getProfile(String userId);

  /// Потоковое получение профиля пользователя
  Stream<UserProfile?> watchProfile(String userId);

  /// Обновить информацию о бизнесе пользователя
  Future<void> updateBusinessInfo(String userId, BusinessInfo businessInfo);

  /// Добавить или обновить навык пользователя
  Future<void> addOrUpdateSkill(String userId, String skillId, int value);

  /// Удалить навык пользователя
  Future<void> removeSkill(String userId, String skillId);

  /// Добавить достижение пользователю
  Future<void> addAchievement(String userId, String achievementId);

  /// Удалить достижение пользователя
  Future<void> removeAchievement(String userId, String achievementId);

  /// Синхронизировать профиль пользователя (например, после оффлайн-режима)
  Future<void> syncProfile(String userId);
}
