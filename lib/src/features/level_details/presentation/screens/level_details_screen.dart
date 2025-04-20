import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/level.dart';
import '../../../../domain/models/progress.dart';
import '../../../../domain/models/video.dart';
import '../../../../domain/models/test.dart';
import '../../../../domain/models/artifact.dart';
import '../../../../application/services/content_integration_service.dart';
import '../../../../application/providers/video_providers.dart';
import '../../../../application/providers/artifact_providers.dart'
    hide progressManagerProvider;
import '../../../../application/providers/progress_providers.dart';
import '../../../../application/providers/test_providers.dart';
import 'package:go_router/go_router.dart';

final contentIntegrationServiceProvider =
    Provider.family<ContentIntegrationService, String>((ref, userId) {
      final videoService = ref.watch(videoServiceProvider);
      final artifactsManager = ref.watch(artifactsManagerProvider);
      final progressManager = ref.watch(progressManagerProvider);
      final videoProgressTracker = ref.watch(
        videoProgressTrackerProvider(userId),
      );
      // TODO: получить реальный TestEngine (например, через testEngineProvider)
      final testEngine =
          ref.watch(testEngineProvider) ??
          (throw UnimplementedError('TestEngine должен быть реализован'));
      return ContentIntegrationService(
        videoService: videoService,
        testEngine: testEngine,
        artifactsManager: artifactsManager,
        progressManager: progressManager,
        videoProgressTracker: videoProgressTracker,
      );
    });

class LevelDetailsScreen extends ConsumerWidget {
  final Level level;
  final String userId;

  const LevelDetailsScreen({
    Key? key,
    required this.level,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Получаем ContentIntegrationService через провайдер
    final contentIntegrationService = ref.watch(
      contentIntegrationServiceProvider(userId),
    );
    return FutureBuilder<List<ContentStep>>(
      future: contentIntegrationService.getContentSteps(level.contents),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final steps = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(level.title)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  level.description ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              // Прогресс-бар по шагам
              _LevelProgressBar(userId: userId, level: level, steps: steps),
              const SizedBox(height: 16),
              // Список шагов с кнопками перехода
              Expanded(
                child: ListView.builder(
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final step = steps[index];
                    return _ContentStepTile(
                      step: step,
                      userId: userId,
                      level: level,
                      onTap: () {
                        switch (step.type) {
                          case ContentStepType.video:
                            context.goNamed(
                              'video-player',
                              pathParameters: {
                                'levelId': level.id,
                                'videoId': step.id,
                              },
                            );
                            break;
                          case ContentStepType.test:
                            context.goNamed(
                              'test',
                              pathParameters: {
                                'levelId': level.id,
                                'testId': step.id,
                              },
                            );
                            break;
                          case ContentStepType.artifact:
                            context.goNamed(
                              'artifact-details',
                              pathParameters: {
                                'levelId': level.id,
                                'artifactId': step.id,
                              },
                            );
                            break;
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LevelProgressBar extends ConsumerWidget {
  final String userId;
  final Level level;
  final List<ContentStep> steps;
  const _LevelProgressBar({
    required this.userId,
    required this.level,
    required this.steps,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentIntegrationService = ref.watch(
      contentIntegrationServiceProvider(userId),
    );
    return FutureBuilder<ContentStep?>(
      future: contentIntegrationService.getCurrentStep(
        userId,
        level.id,
        level.contents,
      ),
      builder: (context, snapshot) {
        final currentStep = snapshot.data;
        final currentIndex =
            currentStep != null
                ? steps.indexWhere(
                  (s) => s.id == currentStep.id && s.type == currentStep.type,
                )
                : steps.length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LinearProgressIndicator(
            value: steps.isEmpty ? 0 : (currentIndex + 1) / steps.length,
          ),
        );
      },
    );
  }
}

class _ContentStepTile extends ConsumerWidget {
  final ContentStep step;
  final String userId;
  final Level level;
  final VoidCallback onTap;
  const _ContentStepTile({
    required this.step,
    required this.userId,
    required this.level,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentIntegrationService = ref.watch(
      contentIntegrationServiceProvider(userId),
    );
    return FutureBuilder<ContentStep?>(
      future: contentIntegrationService.getCurrentStep(
        userId,
        level.id,
        level.contents,
      ),
      builder: (context, snapshot) {
        final currentStep = snapshot.data;
        final isCurrent =
            currentStep != null &&
            currentStep.id == step.id &&
            currentStep.type == step.type;
        return ListTile(
          leading: Icon(_iconForStep(step.type)),
          title: Text(_titleForStep(step)),
          trailing:
              isCurrent
                  ? const Icon(Icons.arrow_forward, color: Colors.blue)
                  : null,
          onTap: onTap,
        );
      },
    );
  }

  IconData _iconForStep(ContentStepType type) {
    switch (type) {
      case ContentStepType.video:
        return Icons.ondemand_video;
      case ContentStepType.test:
        return Icons.quiz;
      case ContentStepType.artifact:
        return Icons.insert_drive_file;
    }
  }

  String _titleForStep(ContentStep step) {
    switch (step.type) {
      case ContentStepType.video:
        return 'Видео: ${step.id}';
      case ContentStepType.test:
        return 'Тест: ${step.id}';
      case ContentStepType.artifact:
        return 'Артефакт: ${step.id}';
    }
  }
}

// TODO: реализовать contentIntegrationServiceProvider через Riverpod
