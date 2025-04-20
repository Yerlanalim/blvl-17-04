import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_ui_providers.dart';
import '../widgets/profile_header.dart';
import '../widgets/business_info_card.dart';
import '../widgets/user_stats_overview.dart';
import '../widgets/profile_action_buttons.dart';
import '../widgets/skills_visualization/skills_visualization.dart';
import '../widgets/achievements_section.dart';
import 'package:blvl_17_04_tmp/src/application/providers/auth_providers.dart';
import 'package:blvl_17_04_tmp/src/infrastructure/providers/profile_providers.dart';
import 'package:blvl_17_04_tmp/src/application/providers/skills_providers.dart'
    as skills_providers;
import 'package:blvl_17_04_tmp/src/application/providers/achievements_providers.dart'
    as achievements_providers;
import 'package:blvl_17_04_tmp/src/application/providers/progress_providers.dart'
    as progress_providers;
import 'profile_edit_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userId = user?.id ?? '';
    final profileAsync = ref.watch(userProfileProvider(userId));
    final achievementsAsync = ref.watch(
      achievements_providers.userAchievementsProvider(userId),
    );
    final statsAsync = ref.watch(
      progress_providers.progressStatsProvider(userId),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Профиль')),
      body: profileAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка загрузки профиля')),
        data: (profile) {
          if (profile == null) {
            return Center(child: Text('Профиль не найден'));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeader(
                  name: profile.displayName,
                  photoUrl: profile.photoUrl,
                  email: user?.email ?? '',
                ),
                BusinessInfoCard(businessInfo: profile.businessInfo),
                if (statsAsync != null && statsAsync is! Null)
                  UserStatsOverview(stats: statsAsync),
                ProfileActionButtons(
                  onEdit: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileEditScreen(),
                      ),
                    );
                  },
                  onShare: () {
                    // TODO: реализовать шэринг
                  },
                ),
                SkillsVisualization(userId: userId),
                achievementsAsync.when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error:
                      (e, st) =>
                          Center(child: Text('Ошибка загрузки достижений')),
                  data:
                      (achievements) =>
                          AchievementsSection(achievements: achievements),
                ),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
