import '../../domain/models/level.dart';
import '../../infrastructure/models/level_connection.dart';

/// Статус уровня для отображения на карте
enum LevelStatus { available, locked, premium }

/// Модель представления уровня на карте
/// Содержит уровень, статус (доступен/заблокирован/премиум) и координаты для UI.
class LevelMapNodeViewModel {
  final Level level;
  final LevelStatus status;
  final double x;
  final double y;

  LevelMapNodeViewModel({
    required this.level,
    required this.status,
    required this.x,
    required this.y,
  });
}

/// Модель представления карты уровней для UI
/// Содержит список узлов и связей для отрисовки карты.
class LevelMapViewModel {
  final List<LevelMapNodeViewModel> nodes;
  final List<LevelConnection> connections;

  LevelMapViewModel({required this.nodes, required this.connections});
}
