import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/level_map_controller.dart';

final levelMapControllerProvider = ChangeNotifierProvider<LevelMapController>((
  ref,
) {
  return LevelMapController();
});

// Добавить другие провайдеры для состояния UI, выделения, анимаций и т.д.
