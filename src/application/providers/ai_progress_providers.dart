import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_progress_integrator.dart';
import '../services/progress_analyzer.dart';
import '../services/learning_path_tracker.dart';
import '../services/content_recommender.dart';
import '../services/skill_gap_detector.dart';
import '../services/ai_recommendation_engine.dart';
import '../../../lib/src/application/providers/progress_providers.dart';
import '../../../lib/src/application/providers/skills_providers.dart';

final progressAnalyzerProvider = Provider(
  (ref) => ProgressAnalyzer(
    progressManager: ref.read(progressManagerProvider),
    skillsManager: ref.read(skillsManagerProvider),
  ),
);
final learningPathTrackerProvider = Provider((ref) => LearningPathTracker());
final contentRecommenderProvider = Provider((ref) => ContentRecommender());
final skillGapDetectorProvider = Provider(
  (ref) => SkillGapDetector(skillsManager: ref.read(skillsManagerProvider)),
);
final aiRecommendationEngineProvider = Provider(
  (ref) => AIRecommendationEngine(),
);

final aiProgressIntegratorProvider = Provider(
  (ref) => AIProgressIntegrator(
    progressAnalyzer: ref.read(progressAnalyzerProvider),
    learningPathTracker: ref.read(learningPathTrackerProvider),
    contentRecommender: ref.read(contentRecommenderProvider),
    skillGapDetector: ref.read(skillGapDetectorProvider),
    recommendationEngine: ref.read(aiRecommendationEngineProvider),
  ),
);
