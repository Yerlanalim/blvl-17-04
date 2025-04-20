import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/providers/video_providers.dart';
import '../../../../domain/models/video.dart';
import '../controllers/video_player_screen_controller.dart';

final videoPlayerScreenControllerProvider =
    ChangeNotifierProvider<VideoPlayerScreenController>((ref) {
      return VideoPlayerScreenController();
    });

final videoByIdProvider = FutureProvider.family<Video?, String>((
  ref,
  videoId,
) async {
  final videoService = ref.watch(videoServiceProvider);
  // TODO: реализовать метод получения видео по id в VideoService
  // return await videoService.getById(videoId);
  return null; // заглушка
});

// TODO: добавить другие провайдеры для управления состояниями UI
