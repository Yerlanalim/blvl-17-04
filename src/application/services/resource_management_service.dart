/// ResourceManagementService: управление ресурсами приложения
/// Включает освобождение ресурсов, ленивую инициализацию heavy-объектов

import 'dart:developer';

class ResourceManagementService {
  static final ResourceManagementService _instance =
      ResourceManagementService._internal();
  factory ResourceManagementService() => _instance;
  ResourceManagementService._internal();

  final List<void Function()> _disposeCallbacks = [];

  void registerDisposable(void Function() dispose) {
    _disposeCallbacks.add(dispose);
  }

  void disposeAll() {
    for (final dispose in _disposeCallbacks) {
      try {
        dispose();
      } catch (e) {
        log('Error disposing resource: $e', name: 'ResourceManagementService');
      }
    }
    _disposeCallbacks.clear();
  }

  /// Пример ленивой инициализации heavy-объекта
  T lazyInit<T>(T? instance, T Function() creator) {
    return instance ?? creator();
  }
}
