import 'dart:async';
import '../../domain/models/progress.dart';
import '../../domain/models/level.dart';
import '../models/level_map_view_model.dart';
import '../models/level_graph.dart';
import '../../domain/services/progress_manager.dart';
import 'level_map_manager.dart';

/// События прогресса для уведомлений
abstract class ProgressEvent {}

class LevelUnlockedEvent extends ProgressEvent {
  final Level level;
  LevelUnlockedEvent(this.level);
}

class AchievementUnlockedEvent extends ProgressEvent {
  final String achievementId;
  AchievementUnlockedEvent(this.achievementId);
}

/// Интеграционный сервис для связывания прогресса и карты уровней
class ProgressLevelMapIntegrator {
  final ProgressManager progressManager;
  final LevelMapManager levelMapManager;

  ProgressLevelMapIntegrator({
    required this.progressManager,
    required this.levelMapManager,
  });

  /// Поток для реактивного получения модели карты с прогрессом
  Stream<LevelMapViewModel> watchLevelMapWithProgress(String userId) async* {
    // Периодический опрос (можно заменить на стрим из ProgressManager, если появится)
    while (true) {
      try {
        final progress = await progressManager.getUserProgress(userId);
        final levels = await levelMapManager.getAllLevels();
        final connections = await levelMapManager.getLevelConnections();
        // Сопоставляем прогресс с уровнями
        final completed =
            progress.summary.completedLevels.map((e) => e.toString()).toSet();
        final currentLevel = progress.summary.currentLevel.toString();
        final nodes = <LevelMapNodeViewModel>[];
        // Координаты можно рассчитывать по аналогии с LevelMapScreen (простая сетка)
        const double spacing = 120;
        for (int i = 0; i < levels.length; i++) {
          final level = levels[i];
          final levelId = level.id;
          final isCompleted = completed.contains(levelId);
          final isCurrent = currentLevel == levelId;
          final isPremium = level.isPremium ?? false;
          // Доступность: если первый уровень или предыдущий завершён
          final isFirst = connections.every(
            (c) => c['targetLevelId'] != levelId,
          );
          final unlocked =
              isFirst ||
              connections.any(
                (c) =>
                    c['targetLevelId'] == levelId &&
                    completed.contains(c['sourceLevelId']),
              );
          final status =
              isPremium
                  ? LevelStatus.premium
                  : unlocked
                  ? LevelStatus.available
                  : LevelStatus.locked;
          final progressForLevel = progress.levelProgress[levelId];
          final percent = getLevelProgress(progressForLevel);
          final x = (i % 4) * spacing + spacing / 2;
          final y = (i ~/ 4) * spacing + spacing / 2;
          nodes.add(
            LevelMapNodeViewModel(level: level, status: status, x: x, y: y),
          );
        }
        // Получаем LevelConnection из кэша напрямую (обход ограничения интерфейса)
        final rawConnections = levelMapManager.cache.getConnections();
        yield LevelMapViewModel(
          nodes: nodes,
          connections: rawConnections ?? [],
        );
      } catch (e) {
        // В случае ошибки — можно yield предыдущий стейт или пустой
        yield LevelMapViewModel(nodes: [], connections: []);
      }
      await Future.delayed(const Duration(seconds: 2)); // polling interval
    }
  }

  /// Поток для событий прогресса (разблокировка, достижения)
  Stream<ProgressEvent> get progressEvents {
    // TODO: реализовать генерацию событий
    throw UnimplementedError();
  }

  /// Разблокировать уровень (вызывается при выполнении условий)
  Future<void> unlockLevel(String userId, String levelId) async {
    // TODO: реализовать разблокировку через ProgressManager и LevelMapManager
    throw UnimplementedError();
  }

  /// Получить процент выполнения по уровню
  double getLevelProgress(LevelProgress? progress) {
    if (progress == null) return 0.0;
    return progress.progressPercentage;
  }

  /// Получить общий прогресс пользователя (0..1)
  double getOverallProgress(Progress progress, int totalLevels) {
    if (totalLevels == 0) return 0.0;
    return (progress.summary.completedLevels.length / totalLevels).clamp(
      0.0,
      1.0,
    );
  }
}
