import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/entities/weekly_stats.dart';
import '../../l10n/app_localizations.dart';
import '../../presentation/providers/achievements_provider.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/habits_provider.dart';
import '../../presentation/providers/stats_provider.dart';
import '../../shared/widgets/df_app_bar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final userName = ref.watch(authStateProvider.select((v) => v.valueOrNull?.name ?? 'Usuario'));
    final userInitials = ref.watch(authStateProvider.select((v) => v.valueOrNull?.initials ?? 'U'));
    final createdAt = ref.watch(authStateProvider.select((v) => v.valueOrNull?.createdAt));

    final streakAsync = ref.watch(globalStreakProvider);
    final weeklyStatsAsync = ref.watch(weeklyStatsProvider);
    final achievementsAsync = ref.watch(achievementsProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const DFAppBar(title: 'Mi perfil', showBack: true, showSettings: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.s5,
          AppDimensions.s2,
          AppDimensions.s5,
          AppDimensions.s6,
        ),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.blue, Color(0xFFA78BFA)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x663D7BFF),
                        blurRadius: 32,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(userInitials,
                      style: AppTypography.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(height: AppDimensions.s3),
                Text(userName,
                    style: AppTypography.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    )),
                const SizedBox(height: 2),
                Text(
                    createdAt != null ? l10n.memberSince(_formatMemberSince(createdAt, l10n)) : l10n.recentMember,
                    style: AppTypography.caption),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.s5),

          Row(
            children: [
              _StatTile(
                value: '${streakAsync.valueOrNull ?? 0}',
                label: l10n.currentStreak,
              ),
              const SizedBox(width: AppDimensions.s2 + 2),
              _StatTile(
                value: _formatCompletion(weeklyStatsAsync.valueOrNull),
                label: 'Esta semana',
              ),
              const SizedBox(width: AppDimensions.s2 + 2),
              _StatTile(
                value: '${achievementsAsync.valueOrNull?.where((a) => a.isUnlocked).length ?? 0}',
                label: l10n.achievementsTitle,
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.s5),

          achievementsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (achievements) {
              final unlocked = achievements.where((a) => a.isUnlocked).length;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(l10n.achievementsTitle,
                            style: AppTypography.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            )),
                      ),
                      Text('$unlocked / ${achievements.length}',
                          style: AppTypography.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDim,
                          )),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.s3),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: AppDimensions.s2 + 2,
                    mainAxisSpacing: AppDimensions.s2 + 2,
                    childAspectRatio: 0.85,
                    children: achievements.map((a) {
                      return Opacity(
                        opacity: a.isUnlocked ? 1.0 : 0.45,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.s4 - 2,
                            horizontal: AppDimensions.s2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(AppDimensions.rMd),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: a.isUnlocked
                                      ? AppColors.catPersonal.withAlpha(34)
                                      : AppColors.surface2,
                                  borderRadius:
                                      BorderRadius.circular(AppDimensions.rSm + 2),
                                ),
                                child: Icon(_achievementIcon(a.icon),
                                    size: 22,
                                    color: a.isUnlocked ? AppColors.catPersonal : AppColors.textMute),
                              ),
                              const SizedBox(height: AppDimensions.s2),
                              Text(a.title,
                                  style: AppTypography.inter(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.1,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: AppDimensions.s5),

          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
            ),
            child: Column(
              children: [
                _ShortcutTile(
                    icon: Icons.settings_outlined, label: l10n.settingsShortcut),
                _ShortcutTile(icon: Icons.shield_outlined, label: l10n.privacyShortcut),
                _ShortcutTile(
                    icon: Icons.help_outline_rounded,
                    label: l10n.helpShortcut,
                    last: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatMemberSince(String isoDate, AppLocalizations l10n) {
    try {
      final date = DateTime.parse(isoDate);
      final months = [
        '', l10n.monthJanuary, l10n.monthFebruary, l10n.monthMarch,
        l10n.monthApril, l10n.monthMay, l10n.monthJune,
        l10n.monthJuly, l10n.monthAugust, l10n.monthSeptember,
        l10n.monthOctober, l10n.monthNovember, l10n.monthDecember
      ];
      return '${months[date.month]} ${date.year}';
    } catch (_) {
      return isoDate;
    }
  }

  String _formatCompletion(WeeklyStatsEntity? stats) {
    final pct = stats?.completionPercentage ?? 0;
    return '${pct.toInt()}%';
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
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.s4 - 2,
          horizontal: AppDimensions.s2,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
        ),
        child: Column(
          children: [
            Text(value,
                style: AppTypography.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                  height: 1,
                )),
            const SizedBox(height: AppDimensions.s1 + 2),
            Text(label,
                style: AppTypography.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDim,
                  letterSpacing: -0.1,
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  const _ShortcutTile({required this.icon, required this.label, this.last = false});
  final IconData icon;
  final String label;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.s4,
        vertical: AppDimensions.s4 - 2,
      ),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textDim),
          const SizedBox(width: AppDimensions.s4 - 2),
          Expanded(
            child: Text(label,
                style: AppTypography.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                )),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.textMute, size: 16),
        ],
      ),
    );
  }
}