import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/df_date_utils.dart';
import '../../../domain/entities/daily_summary.dart';
import '../../../domain/entities/task.dart';
import '../../providers/stats_provider.dart';
import '../../providers/tasks_provider.dart';
import '../../widgets/df_empty.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayStats = ref.watch(todayStatsProvider);
    final allTasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.s5,
                  AppDimensions.s4,
                  AppDimensions.s5,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Hola!',
                      style: AppTypography.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.s1 + 2),
                    Text(
                      DFDateUtils.displayDate(DFDateUtils.today()),
                      style: AppTypography.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDim,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.s5),
                    todayStats.when(
                      loading: () => const SizedBox.shrink(),
                      error: (err, stack) => const SizedBox.shrink(),
                      data: (stats) => _DashboardCards(stats: stats),
                    ),
                    const SizedBox(height: AppDimensions.s5),
                    _sectionTitle('Próximas actividades'),
                  ],
                ),
              ),
            ),
            allTasksAsync.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: Center(child: Text('Error: $e')),
              ),
              data: (tasks) {
                final today = DFDateUtils.today();
                final upcoming = tasks
                    .where((t) => t.date == today && !t.completed)
                    .toList()
                  ..sort((a, b) => a.time.compareTo(b.time));

                if (upcoming.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: DFEmpty(
                      icon: Icons.check_circle_outline_rounded,
                      title: 'No tienes actividades pendientes hoy',
                      subtitle: '¡Buen trabajo! Disfruta tu día.',
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.s5,
                  ),
                  sliver: SliverList.separated(
                    itemCount: upcoming.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final t = upcoming[i];
                      return _UpcomingTaskCard(task: t);
                    },
                  ),
                );
              },
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: AppDimensions.s6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
        text,
        style: AppTypography.inter(
          fontSize: 16.5,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      );
}

class _DashboardCards extends StatelessWidget {
  const _DashboardCards({required this.stats});
  final DailySummaryEntity stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SummaryCard(
          label: 'Actividades\ntotales',
          value: '${stats.totalActivities}',
          color: AppColors.catAcademic,
          icon: Icons.calendar_today_outlined,
        ),
        const SizedBox(width: AppDimensions.s2 + 2),
        _SummaryCard(
          label: 'Completadas',
          value: '${stats.completedActivities}',
          color: AppColors.catHealth,
          icon: Icons.check_rounded,
        ),
        const SizedBox(width: AppDimensions.s2 + 2),
        _SummaryCard(
          label: 'Pendientes',
          value: '${stats.pendingActivities}',
          color: AppColors.catPersonal,
          icon: Icons.access_time_outlined,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 116,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
        ),
        padding: const EdgeInsets.all(AppDimensions.s3 - 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(64),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            const Spacer(),
            Text(
              value,
              style: AppTypography.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppDimensions.s1),
            Text(
              label,
              style: AppTypography.inter(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Colors.white.withAlpha(235),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingTaskCard extends StatelessWidget {
  const _UpcomingTaskCard({required this.task});
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/task-detail', extra: task),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.s4 - 2),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              child: Text(
                DFDateUtils.formatTime(task.time),
                style: AppTypography.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: AppTypography.inter(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    switch (task.category) {
                      TaskCategory.academic => 'Académica',
                      TaskCategory.health => 'Salud',
                      TaskCategory.personal => 'Personal',
                    },
                    style: AppTypography.inter(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDim,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _categoryColor(task.category),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _categoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.academic:
        return AppColors.catAcademic;
      case TaskCategory.health:
        return AppColors.catHealth;
      case TaskCategory.personal:
        return AppColors.catPersonal;
    }
  }
}
