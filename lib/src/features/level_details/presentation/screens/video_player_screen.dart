import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/providers/video_providers.dart';
import '../../../../application/providers/progress_providers.dart';
import '../../../../domain/models/video.dart';
import '../widgets/video_player_controls.dart';
import '../widgets/video_progress_bar.dart';
import '../widgets/video_quality_selector.dart';
import '../widgets/video_volume_control.dart';
import '../widgets/video_error_display.dart';
import '../widgets/video_loading_indicator.dart';
import '../widgets/video_completion_notification.dart';
import '../widgets/video_related_content.dart';
import '../providers/video_ui_providers.dart';
import '../controllers/video_player_screen_controller.dart';

class VideoPlayerScreen extends ConsumerWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(videoPlayerScreenControllerProvider);
    final currentVideoId = ref.watch(currentVideoIdProvider);
    final videoService = ref.watch(videoServiceProvider);
    final playbackStateAsync = ref.watch(playbackStateProvider);
    // TODO: получить userId из auth
    final userId = 'mock_user';
    final userProgressAsync = ref.watch(userProgressProvider(userId));

    final videoAsync =
        currentVideoId != null
            ? ref.watch(videoByIdProvider(currentVideoId))
            : const AsyncValue<Video?>.loading();

    // MOCK: связанные тесты и артефакты (заменить на реальные)
    final tests = ['Тест 1', 'Тест 2'];
    final artifacts = ['Артефакт 1', 'Артефакт 2'];

    // MOCK: качества и громкость
    final qualities = ['360p', '720p', '1080p'];
    final selectedQuality = controller.quality;
    final volume = controller.volume;

    // MOCK: прогресс
    final progress = controller.progress;

    // MOCK: состояния
    final state = controller.state;
    final errorMessage = controller.errorMessage ?? '';

    Widget videoArea = AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: Center(
          child: Icon(Icons.ondemand_video, color: Colors.white, size: 64),
        ),
      ),
    );

    Widget controls = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VideoProgressBar(progress: progress),
        VideoPlayerControls(
          onPlay: controller.play,
          onPause: controller.pause,
          onRewind: () {}, // TODO: реализовать перемотку
          onForward: () {}, // TODO: реализовать перемотку
          isPlaying: state == VideoPlayerState.playing,
        ),
        Row(
          children: [
            Expanded(
              child: VideoQualitySelector(
                qualities: qualities,
                selectedQuality: selectedQuality,
                onQualitySelected: controller.setQuality,
              ),
            ),
            Expanded(
              child: VideoVolumeControl(
                volume: volume,
                onVolumeChanged: controller.setVolume,
              ),
            ),
          ],
        ),
      ],
    );

    Widget body;
    if (videoAsync.isLoading) {
      body = const VideoLoadingIndicator();
    } else if (videoAsync.hasError) {
      body = VideoErrorDisplay(
        errorMessage: videoAsync.error.toString(),
        onRetry: controller.retry,
      );
    } else {
      final video = videoAsync.value;
      if (state == VideoPlayerState.loading ||
          state == VideoPlayerState.buffering) {
        body = const VideoLoadingIndicator();
      } else if (state == VideoPlayerState.error) {
        body = VideoErrorDisplay(
          errorMessage: errorMessage,
          onRetry: controller.retry,
        );
      } else if (state == VideoPlayerState.completed) {
        body = VideoCompletionNotification(onNext: controller.next);
      } else {
        body = LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Мобильная/портретная верстка
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    videoArea,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video?.title ?? 'Заголовок видео',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 8),
                          Text(video?.description ?? 'Описание видео...'),
                          SizedBox(height: 8),
                          Text(
                            'Длительность: ${video != null ? (video.duration ~/ 60).toString().padLeft(2, '0') + ":" + (video.duration % 60).toString().padLeft(2, '0') : '10:00'}',
                          ),
                        ],
                      ),
                    ),
                    controls,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: VideoRelatedContent(
                        tests: tests,
                        artifacts: artifacts,
                        onTestTap: () {},
                        onArtifactTap: () {},
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Десктоп/планшет: видео и описание сбоку
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(children: [videoArea, controls]),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video?.title ?? 'Заголовок видео',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 8),
                          Text(video?.description ?? 'Описание видео...'),
                          SizedBox(height: 8),
                          Text(
                            'Длительность: ${video != null ? (video.duration ~/ 60).toString().padLeft(2, '0') + ":" + (video.duration % 60).toString().padLeft(2, '0') : '10:00'}',
                          ),
                          SizedBox(height: 16),
                          VideoRelatedContent(
                            tests: tests,
                            artifacts: artifacts,
                            onTestTap: () {},
                            onArtifactTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Видео')), // TODO: адаптировать для fullscreen
      body: SafeArea(child: body),
    );
  }
}
