// TODO: Реализация маршрутов приложения с помощью GoRouter

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'route_paths.dart';
import 'router_notifier.dart';
import 'route_guards.dart';
import 'transitions/page_transitions.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/auth_success_screen.dart';
import '../main.dart';
import 'models/route_params.dart';
import '../application/providers/auth_providers.dart';
import '../features/level_details/presentation/screens/level_details_screen.dart';
import '../features/level_details/presentation/screens/video_player_screen.dart';
import '../features/level_details/presentation/screens/test_screen.dart';
import '../features/level_details/presentation/screens/artifact_details_screen.dart';
import '../domain/models/level.dart';

// Заглушки для защищённых маршрутов
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Профиль')));
}

class LevelScreen extends StatelessWidget {
  final String levelId;
  const LevelScreen({super.key, required this.levelId});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Уровень: $levelId')));
}

class ArtifactsScreen extends StatelessWidget {
  const ArtifactsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Артефакты')));
}

class AIAssistantScreen extends StatelessWidget {
  const AIAssistantScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('AI-ассистент')));
}

GoRouter createAppRouter(Ref ref, RouterNotifier notifier) {
  return GoRouter(
    refreshListenable: notifier,
    initialLocation: homePath,
    debugLogDiagnostics: true,
    routes: [
      // Публичные маршруты
      GoRoute(
        path: loginPath,
        name: 'login',
        pageBuilder:
            (context, state) => fadeTransitionPage(child: const LoginScreen()),
      ),
      GoRoute(
        path: registerPath,
        name: 'register',
        pageBuilder:
            (context, state) =>
                fadeTransitionPage(child: const RegisterScreen()),
      ),
      GoRoute(
        path: forgotPasswordPath,
        name: 'forgot-password',
        pageBuilder:
            (context, state) =>
                fadeTransitionPage(child: const ForgotPasswordScreen()),
      ),
      GoRoute(
        path: authSuccessPath,
        name: 'auth-success',
        pageBuilder:
            (context, state) =>
                fadeTransitionPage(child: const AuthSuccessScreen()),
      ),
      // Защищённые маршруты
      GoRoute(
        path: homePath,
        name: 'home',
        pageBuilder:
            (context, state) =>
                fadeTransitionPage(child: const StartupScreen()),
      ),
      GoRoute(
        path: profilePath,
        name: 'profile',
        pageBuilder:
            (context, state) =>
                fadeTransitionPage(child: const ProfileScreen()),
      ),
      GoRoute(
        path: '$levelPath/:id',
        name: 'level',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return fadeTransitionPage(child: LevelScreen(levelId: id));
        },
      ),
      GoRoute(
        path: artifactsPath,
        name: 'artifacts',
        pageBuilder:
            (context, state) =>
                fadeTransitionPage(child: const ArtifactsScreen()),
      ),
      GoRoute(
        path: aiAssistantPath,
        name: 'ai-assistant',
        pageBuilder:
            (context, state) =>
                fadeTransitionPage(child: const AIAssistantScreen()),
      ),
      GoRoute(
        path: '$levelPath/:id/details',
        name: 'level-details',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          // TODO: получить userId из auth
          final userId = 'mock_user';
          // TODO: получить Level по id (например, через провайдер)
          final level = Level(
            id: id,
            title: 'Level $id',
            description: '',
            order: 0,
            isPremium: false,
            contents: LevelContents(videoIds: [], testIds: [], artifactIds: []),
          );
          return fadeTransitionPage(
            child: LevelDetailsScreen(level: level, userId: userId),
          );
        },
      ),
      GoRoute(
        path: '$levelPath/:levelId/video/:videoId',
        name: 'video-player',
        pageBuilder: (context, state) {
          // TODO: получить userId из auth
          final userId = 'mock_user';
          final videoId = state.pathParameters['videoId']!;
          // TODO: получить Video по id (через провайдер)
          return fadeTransitionPage(child: VideoPlayerScreen());
        },
      ),
      GoRoute(
        path: '$levelPath/:levelId/test/:testId',
        name: 'test',
        pageBuilder: (context, state) {
          // TODO: получить userId из auth
          final userId = 'mock_user';
          final testId = state.pathParameters['testId']!;
          // TODO: получить Test по id (через провайдер)
          return fadeTransitionPage(child: TestScreen());
        },
      ),
      GoRoute(
        path: '$levelPath/:levelId/artifact/:artifactId',
        name: 'artifact-details',
        pageBuilder: (context, state) {
          // TODO: получить userId из auth
          final userId = 'mock_user';
          final artifactId = state.pathParameters['artifactId']!;
          // TODO: получить Artifact по id (через провайдер)
          return fadeTransitionPage(child: ArtifactDetailsScreen());
        },
      ),
    ],
    errorBuilder:
        (context, state) => const Scaffold(
          body: Center(child: Text('Страница не найдена')), // 404
        ),
    redirect: (context, state) {
      final ref = notifier.ref;
      final authState = ref.read(authStateProvider);
      final isAuth = authState.asData?.value.isAuthenticated == true;
      final loggingIn =
          state.uri.path == loginPath ||
          state.uri.path == registerPath ||
          state.uri.path == forgotPasswordPath;
      final intended = state.fullPath ?? homePath;
      // Если неавторизован и не на публичном маршруте — редирект на /login
      if (!isAuth && !loggingIn) {
        return '$loginPath?redirect=$intended';
      }
      // Если авторизован и на публичном маршруте — редирект на /
      if (isAuth && loggingIn) {
        return homePath;
      }
      return null;
    },
    // Deep linking поддерживается из коробки
  );
}
