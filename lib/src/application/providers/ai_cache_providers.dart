import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_cache_manager.dart';
import '../services/ai_usage_tracker.dart';
import '../services/ai_preloader.dart';
import '../services/context_optimizer.dart';
import '../strategies/cache_invalidation_strategy.dart';
import '../strategies/context_prioritization_strategy.dart';
import '../../infrastructure/repositories/ai_cache_repository.dart';

final aiCacheRepositoryProvider = Provider<IAICacheRepository>(
  (ref) => AICacheRepository(),
);

final aiCacheManagerProvider = Provider<AICacheManager>(
  (ref) => AICacheManager(ref.watch(aiCacheRepositoryProvider)),
);

final aiUsageTrackerProvider = Provider<AIUsageTracker>(
  (ref) => AIUsageTracker(),
);

final aiPreloaderProvider = Provider<AIPreloader>(
  (ref) => AIPreloader(ref.watch(aiCacheRepositoryProvider)),
);

final contextOptimizerProvider = Provider<ContextOptimizer>(
  (ref) => ContextOptimizer(),
);

final cacheInvalidationStrategyProvider = Provider<CacheInvalidationStrategy>(
  (ref) => TtlInvalidationStrategy(),
);

final contextPrioritizationStrategyProvider =
    Provider<ContextPrioritizationStrategy>((ref) => TimeBasedPrioritization());
