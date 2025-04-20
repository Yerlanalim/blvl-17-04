import 'package:flutter/foundation.dart';
import '../../domain/services/auth_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/models/user.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/models/auth_credentials.dart';
import '../../domain/models/auth_state.dart';
import '../../infrastructure/services/cache_manager.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import 'session_manager.dart';
import 'user_profile_initializer.dart';

class AuthServiceImpl implements IAuthService {
  final IAuthRepository _authRepository;
  final CacheManager _cacheManager;
  final FirestoreDataService _firestoreService;
  final SessionManager _sessionManager;
  final UserProfileInitializer _profileInitializer;

  AuthServiceImpl({
    required IAuthRepository authRepository,
    required CacheManager cacheManager,
    required FirestoreDataService firestoreService,
    required SessionManager sessionManager,
    required UserProfileInitializer profileInitializer,
  }) : _authRepository = authRepository,
       _cacheManager = cacheManager,
       _firestoreService = firestoreService,
       _sessionManager = sessionManager,
       _profileInitializer = profileInitializer;

  @override
  Future<User> register(AuthCredentials credentials) async {
    // 1. Регистрация пользователя через репозиторий
    final user = await _authRepository.signUpWithEmailPassword(credentials);

    // 2. Инициализация профиля и прогресса (Firestore транзакция)
    final initializedUser = await _profileInitializer
        .initializeProfileAndProgress(user);

    // 3. Кэширование профиля пользователя
    _cacheManager.set<UserProfile>(
      'user_profile_${user.id}',
      initializedUser.profile,
    );

    // 4. Возврат пользователя с инициализированным профилем
    return initializedUser;
  }

  @override
  Future<User> login(AuthCredentials credentials) async {
    // 1. Вход пользователя через репозиторий
    final user = await _authRepository.signInWithEmailPassword(credentials);

    // 2. Загрузка профиля пользователя из Firestore
    final profile = await _firestoreService.read<UserProfile>(
      'user_profiles',
      user.id,
    );
    final userWithProfile = user.copyWith(profile: profile!);

    // 3. Кэширование профиля пользователя
    _cacheManager.set<UserProfile>('user_profile_${user.id}', profile);

    // 4. Возврат пользователя с профилем
    return userWithProfile;
  }

  @override
  Future<User> loginWithGoogle() async {
    // 1. Вход пользователя через Google
    final user = await _authRepository.signInWithGoogle();

    // 2. Загрузка профиля пользователя из Firestore
    final profile = await _firestoreService.read<UserProfile>(
      'user_profiles',
      user.id,
    );
    final userWithProfile = user.copyWith(profile: profile!);

    // 3. Кэширование профиля пользователя
    _cacheManager.set<UserProfile>('user_profile_${user.id}', profile);

    // 4. Возврат пользователя с профилем
    return userWithProfile;
  }

  @override
  Future<void> logout() async {
    await _authRepository.signOut();
    _sessionManager.clearSession();
  }

  @override
  User? getCurrentUser() {
    // TODO: Получение текущего пользователя
    throw UnimplementedError();
  }

  @override
  Stream<AuthState> observeAuthState() {
    return _authRepository.authStateChanges();
  }

  @override
  Future<UserProfile> getProfile(String userId) async {
    // 1. Попытка получить профиль из кэша
    final cached = _cacheManager.get<UserProfile>('user_profile_$userId');
    if (cached != null) return cached;

    // 2. Если нет в кэше — загрузка из Firestore
    final profile = await _firestoreService.read<UserProfile>(
      'user_profiles',
      userId,
    );
    if (profile != null) {
      _cacheManager.set<UserProfile>('user_profile_$userId', profile);
      return profile;
    }
    throw Exception('User profile not found');
  }

  @override
  Future<void> updateProfile(String userId, UserProfile profile) async {
    // 1. Обновление профиля в Firestore
    await _firestoreService.update('user_profiles', userId, profile.toJson());
    // 2. Обновление кэша
    _cacheManager.set<UserProfile>('user_profile_$userId', profile);
  }

  @override
  Stream<UserProfile> observeProfile(String userId) async* {
    // TODO: Реализация стрима изменений профиля пользователя (например, через snapshots Firestore)
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _authRepository.resetPassword(email);
  }

  @override
  Future<void> refreshToken() async {
    await _sessionManager.refreshToken();
  }
}
