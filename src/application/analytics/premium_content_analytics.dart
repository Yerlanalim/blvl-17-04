import 'dart:collection';

/// Сервис аналитики премиум-контента
class PremiumContentAnalytics {
  final List<_AccessAttempt> _attempts = [];
  final Map<String, int> _premiumContentViews = {};

  /// Логирует попытку доступа к премиум-контенту
  void logAccessAttempt(
    String userId,
    String contentType,
    String contentId,
    bool hasAccess,
  ) {
    _attempts.add(
      _AccessAttempt(
        userId: userId,
        contentType: contentType,
        contentId: contentId,
        timestamp: DateTime.now(),
        hasAccess: hasAccess,
      ),
    );
    if (hasAccess) {
      _premiumContentViews[contentId] =
          (_premiumContentViews[contentId] ?? 0) + 1;
    }
  }

  /// Получить статистику по попыткам доступа
  List<_AccessAttempt> getAccessAttempts({String? userId}) {
    if (userId == null) return List.unmodifiable(_attempts);
    return _attempts.where((a) => a.userId == userId).toList();
  }

  /// Получить топ востребованного премиум-контента
  List<String> getMostPopularPremiumContent({int top = 5}) {
    final sorted =
        _premiumContentViews.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(top).map((e) => e.key).toList();
  }
}

class _AccessAttempt {
  final String userId;
  final String contentType;
  final String contentId;
  final DateTime timestamp;
  final bool hasAccess;

  _AccessAttempt({
    required this.userId,
    required this.contentType,
    required this.contentId,
    required this.timestamp,
    required this.hasAccess,
  });
}
