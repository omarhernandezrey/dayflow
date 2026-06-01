import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/weekly_stats.dart';
import '../../providers/stats_provider.dart';
import '../../widgets/df_error.dart';
import '../../widgets/df_loading.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(weeklyStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: statsAsync.when(
          loading: () => const DFLoading(),
          error: (e, _) => DFError(
            message: e.toString(),
            onRetry: () => ref.invalidate(weeklyStatsProvider),
          ),
          data: (stats) => _StatsBody(stats: stats),
        ),
      ),
    );
  }
}

class _StatsBody extends StatelessWidget {
  const _StatsBody({required this.stats});
  final WeeklyStatsEntity stats;

  @override
  Widget build(BuildContext context) {
    final pct = stats.completionPercentage;
    final completed = stats.completedTasks;
    final pending = stats.pendingTasks;
    final total = stats.totalTasks;
    final bars = stats.dayBars;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.s5,
        AppDimensions.s4,
        AppDimensions.s5,
        AppDimensions.s6,
      ),
      children: [
        Text(
          'Estadísticas',
          style: AppTypography.inter(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: AppDimensions.s5),

        // Donut chart card
        Container(
          padding: const EdgeInsets.all(AppDimensions.s4 + 2),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.rLg),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Text(
                'Esta semana',
                style: AppTypography.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: AppDimensions.s4),
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: pct > 0 ? pct : 0.001,
                            color: AppColors.blue,
                            radius: 14,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            value: pct < 100 ? (100 - pct) : 0.001,
                            color: AppColors.surface2,
                            radius: 14,
                            showTitle: false,
                          ),
                        ],
                        centerSpaceRadius: 56,
                        sectionsSpace: pct > 0 && pct < 100 ? 2 : 0,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${pct.toInt()}%',
                          style: AppTypography.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.5,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Completado',
                          style: AppTypography.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDim,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppDimensions.s4 - 2),

        // Stat row
        Row(
          children: [
            _StatCard(value: '$completed', label: 'Completadas', color: AppColors.catHealth),
            const SizedBox(width: AppDimensions.s2 + 2),
            _StatCard(value: '$pending', label: 'Pendientes', color: AppColors.catPersonal),
            const SizedBox(width: AppDimensions.s2 + 2),
            _StatCard(value: '$total', label: 'Total', color: AppColors.catAcademic),
          ],
        ),

        const SizedBox(height: AppDimensions.s4 - 2),

        // Weekly bar chart
        Container(
          padding: const EdgeInsets.all(AppDimensions.s4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cumplimiento semanal',
                style: AppTypography.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: AppDimensions.s3),
              SizedBox(
                height: 130,
                child: bars.isEmpty
                    ? Center(
                        child: Text(
                          'Sin datos esta semana',
                          style: AppTypography.inter(
                            fontSize: 13,
                            color: AppColors.textMute,
                          ),
                        ),
                      )
                    : BarChart(
                        BarChartData(
                          maxY: 100,
                          minY: 0,
                          barGroups: bars.asMap().entries.map((e) {
                            final i = e.key;
                            final b = e.value;
                            final dim = b.isFuture;
                            final val = b.value;
                            return BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  toY: val > 0 ? val : 0,
                                  color: dim ? AppColors.surfaceHi : AppColors.blue,
                                  width: 20,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(6),
                                  ),
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 100,
                                    color: AppColors.surface2,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                getTitlesWidget: (value, meta) {
                                  final i = value.toInt();
                                  if (i < 0 || i >= bars.length) {
                                    return const SizedBox.shrink();
                                  }
                                  final dim = bars[i].isFuture;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      bars[i].day,
                                      style: AppTypography.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.1,
                                        color: dim ? AppColors.textMute : AppColors.textDim,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          barTouchData: BarTouchData(enabled: false),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label, required this.color});
  final String value;
  final String label;
  final Color color;

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
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
                color: color,
                height: 1,
              ),
            ),
            const SizedBox(height: AppDimensions.s1 + 2),
            Text(
              label,
              style: AppTypography.inter(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textDim,
                letterSpacing: -0.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
