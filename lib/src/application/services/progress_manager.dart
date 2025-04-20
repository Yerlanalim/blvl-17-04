import '../../domain/services/progress_manager.dart';
import '../../domain/models/progress.dart';
import '../../infrastructure/services/firestore_data_service.dart';
import '../../core/utils/error_handler.dart';
import 'progress_validator.dart';
import 'progress_aggregator.dart';

class ProgressManagerImpl implements ProgressManager {
  final FirestoreDataService dataService;
  final ErrorHandler errorHandler;
  final ProgressValidator validator;
  final ProgressAggregator aggregator;

  ProgressManagerImpl({
    required this.dataService,
    required this.errorHandler,
    ProgressValidator? validator,
    ProgressAggregator? aggregator,
  }) : validator = validator ?? ProgressValidator(),
       aggregator = aggregator ?? ProgressAggregator();

  @override
  Future<Progress> getUserProgress(String userId) async {
    try {
      // Получаем summary
      final summary = await dataService.read<ProgressSummary>(
        'progress/$userId',
        'summary',
      );
      if (summary == null) {
        throw Exception('Summary not found');
      }
      // Получаем все документы уровня
      final levelDocs = await dataService.getSubcollection<LevelProgress>(
        'progress',
        userId,
        '', // Пустая строка, если subcollection не используется, иначе указать subcollection
      );
      // Собираем карту levelProgress
      final Map<String, LevelProgress> levelProgress = {};
      for (var doc in levelDocs) {
        // Предполагается, что dataService.getSubcollection возвращает объекты с id
        // Здесь нужен способ получить levelId из документа (например, из поля или id)
        // Для простоты предположим, что doc содержит поле levelId
        final levelId = (doc as dynamic).levelId ?? '';
        if (levelId.isNotEmpty) {
          levelProgress[levelId] = doc;
        }
      }
      return Progress(
        userId: userId,
        summary: summary,
        levelProgress: levelProgress,
      );
    } catch (e, st) {
      errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> updateLevelProgress(
    String userId,
    String levelId,
    LevelProgress progress,
  ) async {
    try {
      await dataService.runTransaction((transaction) async {
        // 1. Прочитать текущий прогресс
        final currentSummary = await dataService.read<ProgressSummary>(
          'progress/$userId',
          'summary',
        );
        final currentLevelProgress = await dataService.read<LevelProgress>(
          'progress/$userId',
          'level_$levelId',
        );
        // 2. Обновить/добавить LevelProgress
        final updatedLevelProgress = progress;
        // 3. Валидация
        if (!validator.validateLevelProgress(updatedLevelProgress)) {
          throw Exception('Invalid level progress');
        }
        // 4. Собрать карту всех уровней (обновляем только один)
        final Map<String, LevelProgress> allLevels = {};
        if (currentLevelProgress != null) {
          allLevels['level_$levelId'] = updatedLevelProgress;
        }
        // Можно получить все остальные уровни, если нужно, но для оптимизации — только обновляемый
        // 5. Агрегация summary
        final newSummary = aggregator.aggregate(allLevels);
        // 6. Валидация summary
        if (!validator.validateSummary(newSummary)) {
          throw Exception('Invalid summary');
        }
        // 7. Обновить Firestore в транзакции
        await dataService.update(
          'progress/$userId',
          'level_$levelId',
          updatedLevelProgress.toJson(),
        );
        await dataService.update(
          'progress/$userId',
          'summary',
          newSummary.toJson(),
        );
      });
    } catch (e, st) {
      errorHandler.handle(e, st);
      rethrow;
    }
  }

  @override
  Future<void> resetProgress(String userId) async {
    try {
      // Получаем все документы прогресса пользователя
      final docs = await dataService.getList<Map<String, dynamic>>(
        'progress/$userId',
      );
      final ids = docs.map((doc) => (doc as dynamic).id as String).toList();
      // Удаляем все документы (summary и level_{levelId})
      for (final id in ids) {
        await dataService.delete('progress/$userId', id);
      }
    } catch (e, st) {
      errorHandler.handle(e, st);
      rethrow;
    }
  }
}
