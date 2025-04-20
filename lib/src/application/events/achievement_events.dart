import '../../domain/models/achievement.dart';
import 'dart:async';

/// Типы событий достижений
class AchievementEvents {
  static const String unlocked = 'unlocked';
  static const String progress = 'progress';
  static const String received = 'received';
}

/// Очередь событий для оффлайн-режима
class AchievementEventQueue {
  final List<AchievementEvent> _queue = [];

  void add(AchievementEvent event) {
    _queue.add(event);
  }

  List<AchievementEvent> drain() {
    final drained = List<AchievementEvent>.from(_queue);
    _queue.clear();
    return drained;
  }

  bool get isEmpty => _queue.isEmpty;
}
