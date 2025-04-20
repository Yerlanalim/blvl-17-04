import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../repositories/firebase_auth_repository.dart';

final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>((ref) {
  final firebaseAuth = fb.FirebaseAuth.instance;
  final errorHandler = ErrorHandlerImpl();
  final logger = ConsoleLogger();
  return FirebaseAuthRepository(firebaseAuth, errorHandler, logger);
});
