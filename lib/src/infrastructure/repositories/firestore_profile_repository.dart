import 'package:blvl_17_04_tmp/src/domain/repositories/profile_repository.dart';
import 'package:blvl_17_04_tmp/src/domain/models/user_profile.dart';
import 'package:blvl_17_04_tmp/src/domain/models/business_info.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/firestore_data_service.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/services/cache_manager.dart';
import 'package:blvl_17_04_tmp/src/core/utils/error_handler.dart';

class FirestoreProfileRepository implements IProfileRepository {
  final FirestoreDataService _firestoreDataService;
  final CacheManager _cacheManager;
  final ErrorHandler _errorHandler;

  FirestoreProfileRepository({
    required FirestoreDataService firestoreDataService,
    required CacheManager cacheManager,
    required ErrorHandler errorHandler,
  }) : _firestoreDataService = firestoreDataService,
       _cacheManager = cacheManager,
       _errorHandler = errorHandler;

  @override
  Future<UserProfile?> getProfile(String userId) async {
    final cacheKey = 'profile_$userId';
    try {
      // 1. Проверка кэша
      final cached = _cacheManager.get<UserProfile>(cacheKey);
      if (cached != null && !_cacheManager.isExpired(cacheKey)) {
        return cached;
      }
      // 2. Получение из Firestore
      final doc = await _firestoreDataService.read<Map<String, dynamic>>(
        'users',
        userId,
      );
      if (doc == null || doc['profile'] == null) return null;
      final profileJson = doc['profile'] as Map<String, dynamic>;
      final profile = UserProfile.fromJson(profileJson);
      // 3. Сохранение в кэш
      _cacheManager.set<UserProfile>(cacheKey, profile);
      return profile;
    } catch (e, st) {
      _errorHandler.handle(e, st);
      return null;
    }
  }

  @override
  Stream<UserProfile?> watchProfile(String userId) async* {
    final cacheKey = 'profile_$userId';
    try {
      final firestore = _firestoreDataService.firestore;
      final docRef = firestore.collection('users').doc(userId);
      await for (final snapshot in docRef.snapshots()) {
        if (!snapshot.exists ||
            snapshot.data() == null ||
            !(snapshot.data() as Map<String, dynamic>).containsKey('profile')) {
          yield null;
          continue;
        }
        final profileJson =
            (snapshot.data() as Map<String, dynamic>)['profile']
                as Map<String, dynamic>;
        final profile = UserProfile.fromJson(profileJson);
        _cacheManager.set<UserProfile>(cacheKey, profile);
        yield profile;
      }
    } catch (e, st) {
      _errorHandler.handle(e, st);
      yield null;
    }
  }

  @override
  Future<void> updateBusinessInfo(
    String userId,
    BusinessInfo businessInfo,
  ) async {
    final cacheKey = 'profile_$userId';
    try {
      await _firestoreDataService.firestore.runTransaction((transaction) async {
        final docRef = _firestoreDataService.firestore
            .collection('users')
            .doc(userId);
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw Exception('Профиль не найден');
        }
        final data = snapshot.data() as Map<String, dynamic>;
        final profileJson = data['profile'] as Map<String, dynamic>;
        profileJson['businessInfo'] = businessInfo.toJson();
        transaction.update(docRef, {'profile': profileJson});
      });
      _cacheManager.invalidate(cacheKey);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> addOrUpdateSkill(
    String userId,
    String skillId,
    int value,
  ) async {
    final cacheKey = 'profile_$userId';
    try {
      await _firestoreDataService.firestore.runTransaction((transaction) async {
        final docRef = _firestoreDataService.firestore
            .collection('users')
            .doc(userId);
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw Exception('Профиль не найден');
        }
        final data = snapshot.data() as Map<String, dynamic>;
        final profileJson = data['profile'] as Map<String, dynamic>;
        final skills = Map<String, int>.from(profileJson['skills'] ?? {});
        skills[skillId] = value;
        profileJson['skills'] = skills;
        transaction.update(docRef, {'profile': profileJson});
      });
      _cacheManager.invalidate(cacheKey);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> removeSkill(String userId, String skillId) async {
    final cacheKey = 'profile_$userId';
    try {
      await _firestoreDataService.firestore.runTransaction((transaction) async {
        final docRef = _firestoreDataService.firestore
            .collection('users')
            .doc(userId);
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw Exception('Профиль не найден');
        }
        final data = snapshot.data() as Map<String, dynamic>;
        final profileJson = data['profile'] as Map<String, dynamic>;
        final skills = Map<String, int>.from(profileJson['skills'] ?? {});
        skills.remove(skillId);
        profileJson['skills'] = skills;
        transaction.update(docRef, {'profile': profileJson});
      });
      _cacheManager.invalidate(cacheKey);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> addAchievement(String userId, String achievementId) async {
    final cacheKey = 'profile_$userId';
    try {
      await _firestoreDataService.firestore.runTransaction((transaction) async {
        final docRef = _firestoreDataService.firestore
            .collection('users')
            .doc(userId);
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw Exception('Профиль не найден');
        }
        final data = snapshot.data() as Map<String, dynamic>;
        final profileJson = data['profile'] as Map<String, dynamic>;
        final achievements = List<String>.from(
          profileJson['achievements'] ?? [],
        );
        if (!achievements.contains(achievementId)) {
          achievements.add(achievementId);
        }
        profileJson['achievements'] = achievements;
        transaction.update(docRef, {'profile': profileJson});
      });
      _cacheManager.invalidate(cacheKey);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> removeAchievement(String userId, String achievementId) async {
    final cacheKey = 'profile_$userId';
    try {
      await _firestoreDataService.firestore.runTransaction((transaction) async {
        final docRef = _firestoreDataService.firestore
            .collection('users')
            .doc(userId);
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          throw Exception('Профиль не найден');
        }
        final data = snapshot.data() as Map<String, dynamic>;
        final profileJson = data['profile'] as Map<String, dynamic>;
        final achievements = List<String>.from(
          profileJson['achievements'] ?? [],
        );
        achievements.remove(achievementId);
        profileJson['achievements'] = achievements;
        transaction.update(docRef, {'profile': profileJson});
      });
      _cacheManager.invalidate(cacheKey);
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> syncProfile(String userId) async {
    final cacheKey = 'profile_$userId';
    try {
      // Пример: если persistent cache реализован, получить профиль из него
      // Здесь только in-memory, поэтому просто инвалидация
      _cacheManager.invalidate(cacheKey);
      // Можно расширить: если есть локальные изменения, отправить их в Firestore
    } catch (e, st) {
      _errorHandler.handle(e, st);
      rethrow;
    }
  }
}
