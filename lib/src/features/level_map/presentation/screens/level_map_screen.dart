import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/level_node_widget.dart';
import '../widgets/level_map_legend.dart';
import '../widgets/level_connection_widget.dart';
import '../providers/progress_ui_providers.dart';
import '../../../../application/providers/auth_providers.dart';
import '../widgets/level_progress_overview.dart';
import '../widgets/achievement_notification.dart';

class LevelMapScreen extends ConsumerWidget {
  const LevelMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userId = user?.id ?? 'demo'; // fallback для демо
    final mapAsync = ref.watch(progressLevelMapViewModelProvider(userId));
    final eventAsync = ref.watch(progressEventsProvider(userId));
    return Scaffold(
      appBar: AppBar(title: const Text('Карта уровней')),
      body: Stack(
        children: [
          Column(
            children: [
              const LevelMapLegend(),
              mapAsync.when(
                data: (map) {
                  final completed =
                      map.nodes
                          .where(
                            (n) =>
                                n.status == LevelStatus.available &&
                                n.level.completedAt != null,
                          )
                          .length;
                  final total = map.nodes.length;
                  final overallProgress = total > 0 ? completed / total : 0.0;
                  return LevelProgressOverview(
                    map: map,
                    overallProgress: overallProgress,
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (e, st) => const SizedBox.shrink(),
              ),
              Expanded(
                child: mapAsync.when(
                  data: (map) {
                    final nodeSize = 64.0;
                    return InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 2.5,
                      child: SizedBox(
                        width: 4 * 120,
                        height: ((map.nodes.length / 4).ceil()) * 120,
                        child: Stack(
                          children: [
                            // Connections
                            for (final edge in map.connections)
                              Positioned.fill(
                                child: LevelConnectionWidget(
                                  start: Offset(
                                    map.nodes
                                        .firstWhere(
                                          (n) =>
                                              n.level.id == edge.sourceLevelId,
                                        )
                                        .x,
                                    map.nodes
                                        .firstWhere(
                                          (n) =>
                                              n.level.id == edge.sourceLevelId,
                                        )
                                        .y,
                                  ),
                                  end: Offset(
                                    map.nodes
                                        .firstWhere(
                                          (n) =>
                                              n.level.id == edge.targetLevelId,
                                        )
                                        .x,
                                    map.nodes
                                        .firstWhere(
                                          (n) =>
                                              n.level.id == edge.targetLevelId,
                                        )
                                        .y,
                                  ),
                                  isActive:
                                      false, // TODO: вычислять по прогрессу
                                  isCompleted:
                                      false, // TODO: вычислять по прогрессу
                                ),
                              ),
                            // Nodes
                            for (final node in map.nodes)
                              Positioned(
                                left: node.x - nodeSize / 2,
                                top: node.y - nodeSize / 2,
                                width: nodeSize,
                                height: nodeSize,
                                child: LevelNodeWidget(
                                  levelId: node.level.id,
                                  title: node.level.title,
                                  isCurrent:
                                      false, // TODO: вычислять по прогрессу
                                  isCompleted:
                                      node.status == LevelStatus.available &&
                                      node.level.completedAt !=
                                          null, // или по статусу
                                  isLocked: node.status == LevelStatus.locked,
                                  isPremium: node.status == LevelStatus.premium,
                                  progress:
                                      node.level.progressPercentage ??
                                      0.0, // TODO: передавать реальный процент
                                  onTap: () {},
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (e, st) =>
                          Center(child: Text('Ошибка загрузки карты: $e')),
                ),
              ),
            ],
          ),
          if (eventAsync.asData?.value is AchievementUnlockedEvent)
            Positioned(
              top: 32,
              left: 0,
              right: 0,
              child: AchievementNotification(
                message: 'Достижение разблокировано!',
              ),
            ),
          if (eventAsync.asData?.value is LevelUnlockedEvent)
            Positioned(
              top: 32,
              left: 0,
              right: 0,
              child: AchievementNotification(
                message: 'Новый уровень разблокирован!',
              ),
            ),
        ],
      ),
    );
  }
}
