// Для работы этого сервиса необходимо добавить зависимость path_provider в pubspec.yaml:
// dependencies:
//   path_provider: ^2.0.0
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  /// Получить путь к директории для артефактов
  Future<Directory> getArtifactsDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final artifactsDir = Directory('${dir.path}/artifacts');
    if (!await artifactsDir.exists()) {
      await artifactsDir.create(recursive: true);
    }
    return artifactsDir;
  }

  /// Сохранить файл
  Future<File> saveFile(String fileName, List<int> bytes) async {
    final dir = await getArtifactsDirectory();
    final file = File('${dir.path}/$fileName');
    return await file.writeAsBytes(bytes, flush: true);
  }

  /// Получить файл
  Future<File?> getFile(String fileName) async {
    final dir = await getArtifactsDirectory();
    final file = File('${dir.path}/$fileName');
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// Удалить файл
  Future<void> deleteFile(String fileName) async {
    final dir = await getArtifactsDirectory();
    final file = File('${dir.path}/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Проверить наличие файла
  Future<bool> hasFile(String fileName) async {
    final dir = await getArtifactsDirectory();
    final file = File('${dir.path}/$fileName');
    return await file.exists();
  }

  /// Получить размер файла (в байтах)
  Future<int> getFileSize(String fileName) async {
    final dir = await getArtifactsDirectory();
    final file = File('${dir.path}/$fileName');
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }
}
