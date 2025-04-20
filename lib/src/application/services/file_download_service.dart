import 'dart:async';
import 'package:http/http.dart' as http;
import '../../domain/models/download_state.dart';
import '../../infrastructure/services/local_storage_service.dart';

class FileDownloadService {
  final LocalStorageService localStorageService;
  final Map<String, StreamController<DownloadState>> _controllers = {};
  final Map<String, bool> _cancelFlags = {};
  final Map<String, DownloadState> _states = {};

  FileDownloadService({required this.localStorageService});

  /// Скачать файл с прогрессом
  Stream<DownloadState> downloadFile(String url, String fileName) async* {
    if (_controllers.containsKey(fileName)) {
      yield* _controllers[fileName]!.stream;
      return;
    }
    final controller = StreamController<DownloadState>();
    _controllers[fileName] = controller;
    _cancelFlags[fileName] = false;
    DownloadState state = DownloadState(
      fileName: fileName,
      status: DownloadStatus.inProgress,
      progress: 0.0,
    );
    controller.add(state);
    _states[fileName] = state;
    try {
      final response = await http.Client().send(
        http.Request('GET', Uri.parse(url)),
      );
      final contentLength = response.contentLength ?? 0;
      int received = 0;
      final bytes = <int>[];
      await for (final chunk in response.stream) {
        if (_cancelFlags[fileName] == true) {
          state = state.copyWith(status: DownloadStatus.canceled);
          controller.add(state);
          _states[fileName] = state;
          controller.close();
          _controllers.remove(fileName);
          _cancelFlags.remove(fileName);
          return;
        }
        bytes.addAll(chunk);
        received += chunk.length;
        final progress = contentLength > 0 ? received / contentLength : 0.0;
        state = state.copyWith(progress: progress);
        controller.add(state);
        _states[fileName] = state;
      }
      // Сохраняем файл
      await localStorageService.saveFile(fileName, bytes);
      state = state.copyWith(status: DownloadStatus.completed, progress: 1.0);
      controller.add(state);
      _states[fileName] = state;
    } catch (e) {
      state = state.copyWith(
        status: DownloadStatus.failed,
        error: e.toString(),
      );
      controller.add(state);
      _states[fileName] = state;
    } finally {
      controller.close();
      _controllers.remove(fileName);
      _cancelFlags.remove(fileName);
    }
    yield* controller.stream;
  }

  /// Отменить загрузку
  void cancelDownload(String fileName) {
    _cancelFlags[fileName] = true;
  }

  /// Получить текущее состояние загрузки
  DownloadState? getDownloadState(String fileName) {
    return _states[fileName];
  }

  /// Очистить все состояния
  void clear() {
    _controllers.clear();
    _cancelFlags.clear();
    _states.clear();
  }
}
