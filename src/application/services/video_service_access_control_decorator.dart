import 'package:blvl_17_04/lib/src/domain/services/video_service.dart';
import 'package:blvl_17_04/lib/src/domain/models/video.dart';
import 'access_control_service.dart';

class VideoServiceAccessControlDecorator implements IVideoService {
  final IVideoService _inner;
  final AccessControlService _accessControlService;
  final String _userId;

  VideoServiceAccessControlDecorator(
    this._inner,
    this._accessControlService,
    this._userId,
  );

  @override
  Future<Video?> getVideo(String videoId) async {
    final hasAccess = await _accessControlService.hasAccess(
      _userId,
      contentType: 'video',
      contentId: videoId,
    );
    if (!hasAccess) {
      // Можно выбросить исключение или вернуть null/заглушку
      return null;
    }
    return _inner.getVideo(videoId);
  }

  // Прокси для остальных методов
  @override
  Future<List<Video>> getVideosForLevel(String levelId) =>
      _inner.getVideosForLevel(levelId);

  @override
  Future<void> trackVideoProgress(String videoId, Duration position) =>
      _inner.trackVideoProgress(videoId, position);

  @override
  Future<void> markVideoCompleted(String videoId) =>
      _inner.markVideoCompleted(videoId);
}
