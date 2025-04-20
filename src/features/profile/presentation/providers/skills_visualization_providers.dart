import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/skills_visualization_controller.dart';

final skillsVisualizationControllerProvider =
    ChangeNotifierProvider<SkillsVisualizationController>((ref) {
      return SkillsVisualizationController();
    });

// TODO: добавить провайдеры для фильтрации, выбранного навыка, интеграции с SkillsManager
