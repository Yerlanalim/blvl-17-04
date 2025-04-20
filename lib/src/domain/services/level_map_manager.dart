import '../models/level.dart';

/// Интерфейс LevelMapManager для работы с картой уровней
abstract class LevelMapManager {
  /// Получить все уровни для карты
  Future<List<Level>> getAllLevels();

  /// Получить связи между уровнями (например, для визуализации)
  Future<List<Map<String, dynamic>>> getLevelConnections();
}
