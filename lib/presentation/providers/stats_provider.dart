import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/daily_summary.dart';
import '../../domain/entities/monthly_stats.dart';
import '../../domain/entities/weekly_stats.dart';
import 'dependency_providers.dart';
import 'habits_provider.dart';
import 'tasks_provider.dart';

final todayStatsProvider = FutureProvider<DailySummaryEntity>((ref) async {
  ref.watch(tasksProvider);
  ref.watch(habitsProvider);
  ref.watch(todayProgressProvider);
  final useCase = ref.read(getTodayStatsUseCaseProvider);
  final result = await useCase.call();
  return result.getOrElse(() => const DailySummaryEntity());
});

final weeklyStatsProvider = FutureProvider<WeeklyStatsEntity>((ref) async {
  ref.watch(tasksProvider);
  ref.watch(habitsProvider);
  ref.watch(todayProgressProvider);
  final useCase = ref.read(getWeeklyStatsUseCaseProvider);
  final result = await useCase.call();
  return result.getOrElse(() => const WeeklyStatsEntity());
});

final monthlyStatsProvider = FutureProvider.family<MonthlyStatsEntity, (int, int)>(
  (ref, params) async {
    final useCase = ref.read(getMonthlyStatsUseCaseProvider);
    final result = await useCase.call(params.$1, params.$2);
    return result.getOrElse(() => const MonthlyStatsEntity());
  },
);
