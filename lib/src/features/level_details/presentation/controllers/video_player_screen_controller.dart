import 'package:flutter/material.dart';

enum VideoPlayerState { loading, playing, paused, buffering, error, completed }

class VideoPlayerScreenController extends ChangeNotifier {
  VideoPlayerState _state = VideoPlayerState.loading;
  String? _errorMessage;
  double _progress = 0.0;
  String _quality = '720p';
  double _volume = 0.7;
  bool _fullscreen = false;

  VideoPlayerState get state => _state;
  String? get errorMessage => _errorMessage;
  double get progress => _progress;
  String get quality => _quality;
  double get volume => _volume;
  bool get fullscreen => _fullscreen;

  void play() {
    _state = VideoPlayerState.playing;
    notifyListeners();
  }

  void pause() {
    _state = VideoPlayerState.paused;
    notifyListeners();
  }

  void buffer() {
    _state = VideoPlayerState.buffering;
    notifyListeners();
  }

  void complete() {
    _state = VideoPlayerState.completed;
    notifyListeners();
  }

  void error(String message) {
    _state = VideoPlayerState.error;
    _errorMessage = message;
    notifyListeners();
  }

  void setProgress(double value) {
    _progress = value;
    notifyListeners();
  }

  void setQuality(String value) {
    _quality = value;
    notifyListeners();
  }

  void setVolume(double value) {
    _volume = value;
    notifyListeners();
  }

  void retry() {
    _state = VideoPlayerState.loading;
    _errorMessage = null;
    notifyListeners();
    // TODO: повторить загрузку видео
  }

  void next() {
    // TODO: переход к следующему материалу
  }

  void toggleFullscreen() {
    _fullscreen = !_fullscreen;
    notifyListeners();
  }
}
