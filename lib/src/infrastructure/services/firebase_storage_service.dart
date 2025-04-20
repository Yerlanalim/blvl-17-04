import 'package:firebase_storage/firebase_storage.dart';
import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import 'dart:typed_data';

/// Сервис для работы с файлами в Firebase Storage
class FirebaseStorageService {
  final FirebaseStorage storage;
  final ErrorHandler errorHandler;
  final Logger logger;

  FirebaseStorageService({
    required this.storage,
    required this.errorHandler,
    required this.logger,
  });

  /// Загрузить файл в Storage
  Future<String> uploadFile(
    String path,
    Uint8List data, {
    void Function(double progress)? onProgress,
  }) async {
    // TODO: Реализация
    throw UnimplementedError();
  }

  /// Скачать файл из Storage
  Future<Uint8List?> downloadFile(
    String path, {
    void Function(double progress)? onProgress,
  }) async {
    // TODO: Реализация
    throw UnimplementedError();
  }

  /// Возобновить загрузку файла
  Future<String> resumeUpload(
    String path,
    Uint8List data, {
    void Function(double progress)? onProgress,
  }) async {
    // TODO: Реализация
    throw UnimplementedError();
  }

  /// Получить ссылку на файл
  Future<String?> getDownloadUrl(String path) async {
    // TODO: Реализация
    throw UnimplementedError();
  }

  /// Кэширование: получить файл из кэша или Storage
  Future<Uint8List?> getCachedOrFetch(String path) async {
    // TODO: Реализация
    throw UnimplementedError();
  }
}
