import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_profile.dart';
import 'auth_providers.dart';

final userProfileProvider = FutureProvider.family<UserProfile, String>((
  ref,
  userId,
) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getProfile(userId);
});

final userProfileStreamProvider = StreamProvider.family<UserProfile, String>((
  ref,
  userId,
) {
  final authService = ref.watch(authServiceProvider);
  return authService.observeProfile(userId);
});
