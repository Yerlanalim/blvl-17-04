import '../../domain/models/progress.dart';

class ProgressSynchronizer {
  /// Сохранить изменения локально (офлайн)
  Future<void> saveOffline(String userId, Progress progress) async {
    // TODO: Реализовать локальное сохранение прогресса
  }

  /// Синхронизировать локальные изменения с сервером
  Future<void> syncWithServer(String userId) async {
    // TODO: Реализовать синхронизацию прогресса при восстановлении соединения
  }
}
