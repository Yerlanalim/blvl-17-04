import '../models/video.dart';

/// Интерфейс сервиса управления видео
abstract class IVideoService {
  /// Загрузить видео по id
  Future<void> loadVideo(String videoId);

  /// Начать воспроизведение
  Future<void> play();

  /// Пауза
  Future<void> pause();

  /// Перемотка
  Future<void> seek(Duration position);

  /// Получить текущее состояние воспроизведения
  Stream<dynamic> get playbackState;

  /// Получить текущую позицию
  Future<Duration> getCurrentPosition();

  /// Получить длительность видео
  Future<Duration> getDuration();
}
