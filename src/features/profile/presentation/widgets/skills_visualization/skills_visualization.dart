import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../lib/src/application/providers/skills_providers.dart';
import 'skills_radar_chart.dart';
import 'skills_tree_view.dart';
import 'skills_grid_view.dart';
import 'skills_bar_chart.dart';
import '../../controllers/skills_visualization_controller.dart';
import '../../providers/skills_visualization_providers.dart';
import 'skill_detail_card.dart';

enum SkillsVisualizationStyle { radar, tree, grid, bar }

class SkillsVisualization extends ConsumerStatefulWidget {
  final String userId;
  const SkillsVisualization({Key? key, required this.userId}) : super(key: key);

  @override
  ConsumerState<SkillsVisualization> createState() =>
      _SkillsVisualizationState();
}

class _SkillsVisualizationState extends ConsumerState<SkillsVisualization> {
  SkillsVisualizationStyle _style = SkillsVisualizationStyle.radar;

  @override
  Widget build(BuildContext context) {
    final skillsAsync = ref.watch(userSkillsProvider(widget.userId));
    final controller = ref.watch(skillsVisualizationControllerProvider);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStyleSwitcher(context),
            const SizedBox(height: 12),
            SizedBox(
              height: 320,
              child: skillsAsync.when(
                data: (skills) {
                  if (skills.isEmpty) {
                    return Center(child: Text('Навыки не найдены'));
                  }
                  void onSkillTap(String name, int value) {
                    ref
                        .read(skillsVisualizationControllerProvider)
                        .selectSkill(name, value);
                  }

                  switch (_style) {
                    case SkillsVisualizationStyle.radar:
                      return SkillsRadarChart(
                        skills: skills,
                        onSkillTap: onSkillTap,
                      );
                    case SkillsVisualizationStyle.tree:
                      return SkillsTreeView(
                        skills: skills,
                        onSkillTap: onSkillTap,
                      );
                    case SkillsVisualizationStyle.grid:
                      return SkillsGridView(
                        skills: skills,
                        onSkillTap: onSkillTap,
                      );
                    case SkillsVisualizationStyle.bar:
                      return SkillsBarChart(
                        skills: skills,
                        onSkillTap: onSkillTap,
                      );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (e, st) => Center(child: Text('Ошибка загрузки навыков')),
              ),
            ),
          ],
        ),
        if (controller.selectedSkill != null &&
            controller.selectedSkillValue != null)
          Positioned.fill(
            child: GestureDetector(
              onTap:
                  () =>
                      ref
                          .read(skillsVisualizationControllerProvider)
                          .clearSelection(),
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: SkillDetailCard(
                    skillName: controller.selectedSkill!,
                    skillValue: controller.selectedSkillValue!,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStyleSwitcher(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _styleButton(
          context,
          SkillsVisualizationStyle.radar,
          Icons.radar,
          'Радар',
        ),
        _styleButton(
          context,
          SkillsVisualizationStyle.tree,
          Icons.account_tree,
          'Дерево',
        ),
        _styleButton(
          context,
          SkillsVisualizationStyle.grid,
          Icons.grid_view,
          'Сетка',
        ),
        _styleButton(
          context,
          SkillsVisualizationStyle.bar,
          Icons.bar_chart,
          'Диаграмма',
        ),
      ],
    );
  }

  Widget _styleButton(
    BuildContext context,
    SkillsVisualizationStyle style,
    IconData icon,
    String label,
  ) {
    final isSelected = _style == style;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
        onPressed: () => setState(() => _style = style),
        icon: Icon(icon, color: isSelected ? Colors.white : null),
        label: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : null),
        ),
      ),
    );
  }
}
