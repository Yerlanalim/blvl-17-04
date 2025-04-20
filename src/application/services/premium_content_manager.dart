import 'package:blvl_17_04/src/domain/models/level.dart';
import 'package:blvl_17_04/src/domain/models/video.dart';
import 'package:blvl_17_04/src/domain/models/test.dart';
import 'package:blvl_17_04/src/domain/models/artifact.dart';

/// Менеджер премиум-контента: фильтрация, получение списков, проверка статуса
class PremiumContentManager {
  /// Фильтрует список уровней, возвращая только премиум-уровни
  List<Level> filterPremiumLevels(List<Level> levels) {
    return levels.where((level) => level?.isPremium == true).toList();
  }

  /// Фильтрует список видео, возвращая только премиум-видео
  List<Video> filterPremiumVideos(List<Video> videos) {
    return videos.where((video) => video?.isPremium == true).toList();
  }

  /// Фильтрует список тестов, возвращая только премиум-тесты
  List<Test> filterPremiumTests(List<Test> tests) {
    return tests.where((test) => test?.isPremium == true).toList();
  }

  /// Фильтрует список артефактов, возвращая только премиум-артефакты
  List<Artifact> filterPremiumArtifacts(List<Artifact> artifacts) {
    return artifacts.where((artifact) => artifact?.isPremium == true).toList();
  }

  /// Проверяет, является ли контент премиумом (универсальный метод)
  bool isPremiumContent(dynamic content) {
    return content?.isPremium == true;
  }
}
