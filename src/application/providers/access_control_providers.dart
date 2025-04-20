import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/access_control_service.dart';
import '../services/premium_content_manager.dart';
import '../providers/subscription_providers.dart';

final accessControlServiceProvider = Provider<AccessControlService>((ref) {
  final subscriptionManager = ref.watch(subscriptionManagerProvider);
  return AccessControlService(subscriptionManager);
});

final premiumContentManagerProvider = Provider<PremiumContentManager>((ref) {
  return PremiumContentManager();
});

/// Провайдер для проверки доступа к конкретному контенту
final hasAccessProvider = FutureProvider.family
    .autoDispose<bool, _AccessCheckParams>((ref, params) async {
      final accessControl = ref.watch(accessControlServiceProvider);
      return accessControl.hasAccess(
        params.userId,
        contentType: params.contentType,
        contentId: params.contentId,
      );
    });

class _AccessCheckParams {
  final String userId;
  final String? contentType;
  final String? contentId;
  const _AccessCheckParams({
    required this.userId,
    this.contentType,
    this.contentId,
  });
}
