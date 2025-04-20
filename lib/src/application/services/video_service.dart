import '../../domain/services/video_service.dart' hide VideoPlaybackState;
import '../../domain/models/video.dart';
import '../../domain/repositories/video_repository.dart';
import '../models/video_playback_state.dart';
import 'dart:async';

class VideoService implements IVideoService {
  final VideoRepository videoRepository;

  Video? _currentVideo;
  Duration _currentPosition = Duration.zero;
  VideoPlaybackState _state = Idle();
  final _stateController = StreamController<VideoPlaybackState>.broadcast();

  VideoService({required this.videoRepository});

  @override
  Future<void> loadVideo(String videoId) async {
    _state = Loading();
    _stateController.add(_state);
    try {
      final video = await videoRepository.getById(videoId);
      if (video == null) {
        _state = ErrorState('Видео не найдено');
        _stateController.add(_state);
        return;
      }
      _currentVideo = video;
      _currentPosition = Duration.zero;
      _state = Idle();
      _stateController.add(_state);
    } catch (e) {
      _state = ErrorState(e.toString());
      _stateController.add(_state);
    }
  }

  @override
  Future<void> play() async {
    if (_currentVideo == null) return;
    _state = Playing();
    _stateController.add(_state);
  }

  @override
  Future<void> pause() async {
    if (_currentVideo == null) return;
    _state = Paused();
    _stateController.add(_state);
  }

  @override
  Future<void> seek(Duration position) async {
    if (_currentVideo == null) return;
    final duration = Duration(seconds: _currentVideo!.duration);
    if (position > duration) {
      _currentPosition = duration;
    } else if (position < Duration.zero) {
      _currentPosition = Duration.zero;
    } else {
      _currentPosition = position;
    }
    // Состояние не меняем, только позицию
  }

  @override
  Stream<dynamic> get playbackState => _stateController.stream;

  @override
  Future<Duration> getCurrentPosition() async => _currentPosition;

  @override
  Future<Duration> getDuration() async =>
      _currentVideo != null
          ? Duration(seconds: _currentVideo!.duration)
          : Duration.zero;

  void dispose() {
    _stateController.close();
  }
}
