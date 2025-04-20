import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_screen_controller.dart';
// Импорт провайдеров профиля, навыков, достижений, пользователя
import 'package:blvl_17_04_tmp/src/infrastructure/providers/profile_providers.dart';
import 'package:blvl_17_04_tmp/src/application/providers/skills_providers.dart';
import 'package:blvl_17_04_tmp/src/application/providers/achievements_providers.dart';
import 'package:blvl_17_04_tmp/src/application/providers/auth_providers.dart';

final profileScreenControllerProvider =
    ChangeNotifierProvider<ProfileScreenController>((ref) {
      return ProfileScreenController();
    });

// TODO: добавить провайдеры для фильтров, состояний и т.д.
