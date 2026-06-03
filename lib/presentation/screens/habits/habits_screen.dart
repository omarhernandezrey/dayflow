import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/habit.dart';
import '../../../domain/entities/habit_progress.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/celebration_provider.dart';
import '../../providers/habits_provider.dart';
import '../../widgets/df_empty.dart';
import '../../widgets/df_error.dart';
import '../../widgets/df_loading.dart';
import '../../widgets/df_progress_bar.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final habitsAsync = ref.watch(habitsProvider);
    final progressAsync = ref.watch(todayProgressProvider);
    final streakAsync = ref.watch(globalStreakProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: habitsAsync.when(
          loading: () => const DFLoading(),
          error: (e, _) => DFError(
            message: e.toString(),
            onRetry: () => ref.invalidate(habitsProvider),
          ),
          data: (habits) {
            final today = DateTime.now().weekday;
            final todayHabits = habits.where((h) => h.isActiveOnDay(today)).toList();
            final progressMap = progressAsync.valueOrNull ?? {};

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.s5,
                      AppDimensions.s4,
                      AppDimensions.s5,
                      AppDimensions.s2,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.habitsTab,
                            style: AppTypography.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.6,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/add-habit'),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.blueSoft,
                              borderRadius: BorderRadius.circular(AppDimensions.rSm),
                            ),
                            child: const Icon(Icons.add_rounded, color: AppColors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
                    child: _StreakCard(streak: streakAsync.valueOrNull ?? 0),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: AppDimensions.s4)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
                    child: Text(
                      l10n.todayHabits,
                      style: AppTypography.inter(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: AppDimensions.s3)),
                if (todayHabits.isEmpty)
                  SliverToBoxAdapter(
                    child: DFEmpty(
                      icon: Icons.radio_button_unchecked_rounded,
                      title: l10n.noHabitsTitle,
                      subtitle: l10n.noHabitsSubtitle,
                      actionLabel: l10n.noHabitsAction,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
                    sliver: SliverList.separated(
                      itemCount: todayHabits.length,
                       separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final h = todayHabits[i];
                        final progress = progressMap[h.id];
                        return _HabitCard(
                          habit: h,
                          progress: progress,
                        );
                      },
                    ),
                  ),
                if (habits.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: AppDimensions.s6)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
                      child: Text(
                        l10n.allMyHabits.toUpperCase(),
                        style: AppTypography.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDim,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: AppDimensions.s3)),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
                    sliver: SliverList.separated(
                      itemCount: habits.length,
                       separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => _HabitManageTile(habit: habits[i]),
                    ),
                  ),
                ],
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: AppDimensions.s6),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.streak});
  final int streak;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(AppDimensions.s4 + 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.catPersonal.withAlpha(46),
            AppColors.danger.withAlpha(26),
          ],
        ),
        border: Border.all(color: AppColors.catPersonal.withAlpha(64)),
        borderRadius: BorderRadius.circular(AppDimensions.rLg),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.catPersonal.withAlpha(46),
              borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
            ),
            child: const Icon(Icons.local_fire_department_rounded,
                size: 32, color: Color(0xFFF97316)),
          ),
          const SizedBox(width: AppDimensions.s4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dailyStreak,
                  style: AppTypography.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.catPersonal,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$streak',
                  style: AppTypography.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5,
                    height: 1,
                  ),
                ),
                Text(
                  l10n.daysInARow,
                  style: AppTypography.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDim,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitCard extends ConsumerWidget {
  const _HabitCard({required this.habit, this.progress});
  final HabitEntity habit;
  final HabitProgressEntity? progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final color = _hexColor(habit.colorHex);
    final current = progress?.currentValue ?? 0.0;
    final target = progress?.targetValue ?? habit.goal;
    final isCompleted = current >= target;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.s4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(34),
                  borderRadius: BorderRadius.circular(AppDimensions.rSm),
                ),
                child: Icon(_habitIcon(habit.icon), size: 20, color: color),
              ),
              const SizedBox(width: AppDimensions.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.title,
                      style: AppTypography.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      isCompleted ? l10n.completedExclamation : l10n.goalLabel(target.toStringAsFixed(target == target.toInt() ? 0 : 1), habit.unit),
                      style: AppTypography.inter(
                        fontSize: 12,
                        color: isCompleted ? AppColors.success : AppColors.textDim,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (habit.id != null) {
                    if (!isCompleted) {
                      if (current + 1 >= target) {
                        ref.read(celebrationTriggerProvider.notifier).state = true;
                      }
                    }
                    ref.read(todayProgressProvider.notifier).increment(habit.id!, 1);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColors.success : color.withAlpha(34),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check_rounded : Icons.add_rounded,
                    size: 18,
                    color: isCompleted ? Colors.white : color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.s3),
          DFProgressBar(
            current: current,
            target: target,
            color: color,
            height: 8,
            showLabel: false,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${current.toStringAsFixed(current == current.toInt() ? 0 : 1)}/${target.toStringAsFixed(target == target.toInt() ? 0 : 1)} ${habit.unit}',
                style: AppTypography.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDim,
                ),
              ),
              Text(
                '${(current / target * 100).clamp(0, 100).toInt()}%',
                style: AppTypography.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HabitManageTile extends ConsumerWidget {
  const _HabitManageTile({required this.habit});
  final HabitEntity habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final color = _hexColor(habit.colorHex);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.s4,
        vertical: AppDimensions.s3,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.rMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withAlpha(34),
              borderRadius: BorderRadius.circular(AppDimensions.rSm),
            ),
            child: Icon(_habitIcon(habit.icon), size: 20, color: color),
          ),
          const SizedBox(width: AppDimensions.s3),
          Expanded(
            child: Text(
              habit.title,
              style: AppTypography.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/add-habit', extra: habit),
            child: const Icon(Icons.edit_outlined, size: 18, color: AppColors.textDim),
          ),
          const SizedBox(width: AppDimensions.s3),
          GestureDetector(
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: AppColors.surface,
                  title: Text(l10n.deleteHabit,
                      style: AppTypography.inter(fontSize: 17, fontWeight: FontWeight.w700)),
                  content: Text(
                      l10n.deleteHabitConfirm(habit.title),
                      style: AppTypography.body),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancelar',
                          style: AppTypography.inter(color: AppColors.textDim)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Eliminar',
                          style: AppTypography.inter(color: AppColors.danger)),
                    ),
                  ],
                ),
              );
              if (confirm == true && habit.id != null) {
                await ref.read(habitsProvider.notifier).delete(habit.id!);
              }
            },
            child: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.danger),
          ),
        ],
      ),
    );
  }
}

Color _hexColor(String hex) {
  try {
    final clean = hex.replaceAll('#', '');
    return Color(int.parse('FF$clean', radix: 16));
  } catch (_) {
    return AppColors.blue;
  }
}

IconData _habitIcon(String key) {
  return switch (key) {
    'water' => Icons.water_drop_outlined,
    'dumbbell' => Icons.fitness_center_rounded,
    'leaf' => Icons.eco_outlined,
    'moon' => Icons.nights_stay_outlined,
    'book' => Icons.menu_book_outlined,
    'sparkle' => Icons.auto_awesome_outlined,
    _ => Icons.circle_outlined,
  };
}