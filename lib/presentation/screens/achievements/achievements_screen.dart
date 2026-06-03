import 'package:dayflow/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/achievement.dart';
import '../../providers/achievements_provider.dart';
import '../../widgets/df_empty.dart';
import '../../widgets/df_error.dart';
import '../../widgets/df_loading.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(achievementsProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: achievementsAsync.when(
          loading: () => const DFLoading(),
          error: (e, _) => DFError(
            message: e.toString(),
            onRetry: () => ref.invalidate(achievementsProvider),
          ),
          data: (achievements) {
            final l10n = AppLocalizations.of(context)!;
            final unlocked = achievements.where((a) => a.isUnlocked).toList();
            final locked = achievements.where((a) => !a.isUnlocked).toList();

            return ListView(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.s5,
                AppDimensions.s4,
                AppDimensions.s5,
                AppDimensions.s6,
              ),
              children: [
                Text(
                  l10n.achievementsTitle,
                  style: AppTypography.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: AppDimensions.s2),
                Text(
                  '${unlocked.length} ${l10n.achievementsUnlocked}',
                  style: AppTypography.inter(
                    fontSize: 14,
                    color: AppColors.textDim,
                  ),
                ),
                const SizedBox(height: AppDimensions.s5),
                if (unlocked.isNotEmpty) ...[
                  _sectionTitle(l10n.achievementsUnlockedTab),
                  const SizedBox(height: AppDimensions.s3),
                  ...unlocked.map((a) => _AchievementCard(achievement: a, isUnlocked: true)),
                  const SizedBox(height: AppDimensions.s5),
                ],
                if (locked.isNotEmpty) ...[
                  _sectionTitle(l10n.achievementsLockedTab),
                  const SizedBox(height: AppDimensions.s3),
                  ...locked.map((a) => _AchievementCard(achievement: a, isUnlocked: false)),
                ],
                if (achievements.isEmpty)
                   DFEmpty(
                     icon: Icons.emoji_events_outlined,
                     title: l10n.noAchievementsTitle,
                     subtitle: l10n.noAchievementsSubtitle,
                   ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
        text.toUpperCase(),
        style: AppTypography.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.textDim,
          letterSpacing: 0.8,
        ),
      );
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.achievement, required this.isUnlocked});
  final AchievementEntity achievement;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.s3),
      padding: const EdgeInsets.all(AppDimensions.s4),
      decoration: BoxDecoration(
        color: isUnlocked ? AppColors.surface : AppColors.surface.withAlpha(120),
        borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
        border: Border.all(
          color: isUnlocked ? AppColors.border : AppColors.border.withAlpha(80),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? AppColors.catPersonal.withAlpha(34)
                  : AppColors.surface2,
              borderRadius: BorderRadius.circular(AppDimensions.rMd),
            ),
            child: Icon(
              _achievementIcon(achievement.icon),
              size: 24,
              color: isUnlocked ? AppColors.catPersonal : AppColors.textMute,
            ),
          ),
          const SizedBox(width: AppDimensions.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: AppTypography.inter(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                    color: isUnlocked ? AppColors.text : AppColors.textDim,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  achievement.description,
                  style: AppTypography.inter(
                    fontSize: 12,
                    color: AppColors.textDim,
                  ),
                ),
                if (!isUnlocked) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: achievement.completionPercentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${achievement.progress}/${achievement.target}',
                    style: AppTypography.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMute,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isUnlocked)
            const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 24)
          else
            Icon(Icons.lock_outline_rounded, color: AppColors.textMute.withAlpha(120), size: 20),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.05, end: 0);
  }
}

IconData _achievementIcon(String key) {
  return switch (key) {
    'fire' => Icons.local_fire_department_rounded,
    'task' => Icons.check_circle_outline_rounded,
    'star' => Icons.star_rounded,
    'sun' => Icons.wb_sunny_rounded,
    'water' => Icons.water_drop_outlined,
    'calendar' => Icons.calendar_today_outlined,
    'trophy' => Icons.emoji_events_outlined,
    'crown' => Icons.workspace_premium_outlined,
    'backup' => Icons.backup_outlined,
    'habit' => Icons.repeat_rounded,
    _ => Icons.emoji_events_outlined,
  };
}
