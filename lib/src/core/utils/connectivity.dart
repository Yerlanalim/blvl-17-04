import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Абстракция сервиса подключения
abstract class ConnectivityService {
  Future<bool> get isConnected;
  Stream<bool> get onStatusChanged;
}

/// Реализация ConnectivityService
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController.broadcast();

  ConnectivityServiceImpl() {
    _connectivity.onConnectivityChanged.listen((result) {
      _controller.add(_isOnline(result));
    });
  }

  bool _isOnline(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return _isOnline(result);
  }

  @override
  Stream<bool> get onStatusChanged async* {
    yield await isConnected;
    yield* _controller.stream;
  }
}

/// Провайдер ConnectivityService (singleton)
final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityServiceImpl(),
);
