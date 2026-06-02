import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/daily_summary.dart';
import '../../domain/entities/monthly_stats.dart';
import '../../domain/entities/weekly_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/local_database.dart';
import '../../core/utils/df_date_utils.dart';
import '../models/habit_model.dart';

class StatsRepositoryImpl implements StatsRepository {
  final LocalDatabase _db;

  StatsRepositoryImpl(this._db);

  @override
  Future<Either<Failure, DailySummaryEntity>> getTodayStats() async {
    try {
      final today = DFDateUtils.isoDate(DateTime.now());

      final tasks = await _db.queryTasks(where: 'date = ?', whereArgs: [today]);
      final completedTasks = tasks.where((r) => r['completed'] == 1).length;

      final habits = await _db.queryHabits();
      final todayHabits = habits.where((r) {
        final h = HabitModel.fromMap(r);
        return h.isActiveOnDay(DateTime.now().weekday);
      }).length;

      final progress = await _db.queryHabitProgress(
        where: 'date = ? AND current_value >= target_value',
        whereArgs: [today],
      );
      final completedHabits = progress.length;

      final total = tasks.length;
      final overall = total + todayHabits > 0
          ? ((completedTasks + completedHabits) / (total + todayHabits) * 100)
          : 0.0;

      return Right(DailySummaryEntity(
        totalActivities: total,
        completedActivities: completedTasks,
        pendingActivities: total - completedTasks,
        totalHabits: todayHabits,
        completedHabits: completedHabits,
        overallCompletionRate: overall,
      ));
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, WeeklyStatsEntity>> getWeeklyStats() async {
    try {
      final now = DateTime.now();
      final weekStart = DFDateUtils.startOfWeek(now);
      final weekEndStr = DFDateUtils.isoDate(weekStart.add(const Duration(days: 6)));
      final weekStartStr = DFDateUtils.isoDate(weekStart);

      final allWeekTasks = await _db.rawQuery(
        'SELECT date, completed FROM tasks WHERE date BETWEEN ? AND ? ORDER BY date',
        [weekStartStr, weekEndStr],
      );

      final Map<String, _DayData> dayData = {};
      for (int i = 0; i < 7; i++) {
        final day = weekStart.add(Duration(days: i));
        final dateStr = DFDateUtils.isoDate(day);
        dayData[dateStr] = _DayData(
          total: 0,
          completed: 0,
          label: DFDateUtils.dayLabel(day.weekday),
          isFuture: day.isAfter(now),
        );
      }

      for (final row in allWeekTasks) {
        final date = row['date'] as String;
        if (dayData.containsKey(date)) {
          dayData[date]!.total++;
          if (row['completed'] == 1) dayData[date]!.completed++;
        }
      }

      final bars = <DayBarEntity>[];
      int totalTasks = 0;
      int completedTasks = 0;
      for (final entry in dayData.entries) {
        final data = entry.value;
        totalTasks += data.total;
        completedTasks += data.completed;
        final pct = data.total == 0 ? 0.0 : (data.completed / data.total * 100);
        bars.add(DayBarEntity(
          day: data.label,
          value: pct,
          isFuture: data.isFuture,
        ));
      }

      final allHabits = await _db.queryHabits();
      final habitProgressWeek = await _db.rawQuery(
        'SELECT habit_id, date, current_value, target_value FROM habit_progress '
        'WHERE date BETWEEN ? AND ? AND current_value >= target_value',
        [weekStartStr, weekEndStr],
      );

      final completedProgressSet = habitProgressWeek
          .map((r) => '${r['habit_id']}_${r['date']}')
          .toSet();

      int totalChecks = 0;
      int completedChecks = 0;
      for (final row in allHabits) {
        final h = HabitModel.fromMap(row);
        for (int i = 0; i < 7; i++) {
          final day = weekStart.add(Duration(days: i));
          if (h.isActiveOnDay(day.weekday)) {
            totalChecks++;
            final key = '${h.id}_${DFDateUtils.isoDate(day)}';
            if (completedProgressSet.contains(key)) {
              completedChecks++;
            }
          }
        }
      }

      final completionPct = totalTasks == 0 ? 0.0 : (completedTasks / totalTasks * 100);

      return Right(WeeklyStatsEntity(
        completionPercentage: completionPct,
        completedTasks: completedTasks,
        pendingTasks: totalTasks - completedTasks,
        totalTasks: totalTasks,
        completedHabits: completedChecks,
        totalHabits: totalChecks,
        dayBars: bars,
      ));
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, MonthlyStatsEntity>> getMonthlyStats(int year, int month) async {
    try {
      final daysInMonth = DateTime(year, month + 1, 0).day;
      final monthStartStr = '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-01';
      final monthEndStr = '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${daysInMonth.toString().padLeft(2, '0')}';

      final allMonthTasks = await _db.rawQuery(
        'SELECT date, completed FROM tasks WHERE date BETWEEN ? AND ? ORDER BY date',
        [monthStartStr, monthEndStr],
      );

      final Map<String, _DayData> dayData = {};
      for (int day = 1; day <= daysInMonth; day++) {
        final dateStr = '$monthStartStr'.substring(0, 8) + day.toString().padLeft(2, '0');
        dayData[dateStr] = _DayData(total: 0, completed: 0, label: '', isFuture: false);
      }

      int totalCompleted = 0;
      int totalCreated = 0;
      for (final row in allMonthTasks) {
        final date = row['date'] as String;
        if (dayData.containsKey(date)) {
          dayData[date]!.total++;
          totalCreated++;
          if (row['completed'] == 1) {
            dayData[date]!.completed++;
            totalCompleted++;
          }
        }
      }

      final dailyRates = <int, double>{};
      int bestStreak = 0;
      int tempStreak = 0;
      for (int day = 1; day <= daysInMonth; day++) {
        final dateStr = '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
        final data = dayData[dateStr];
        final created = data?.total ?? 0;
        final completed = data?.completed ?? 0;
        dailyRates[day] = created > 0 ? (completed / created * 100) : 0.0;

        if (created > 0 && completed == created) {
          tempStreak++;
          if (tempStreak > bestStreak) bestStreak = tempStreak;
        } else {
          tempStreak = 0;
        }
      }

      int currentStreak = 0;
      DateTime checkDay = DateTime.now();
      while (checkDay.year == year && checkDay.month == month && checkDay.day >= 1) {
        final dateStr = DFDateUtils.isoDate(checkDay);
        final data = dayData[dateStr];
        if (data != null && data.total > 0 && data.completed == data.total) {
          currentStreak++;
          checkDay = checkDay.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }

      final avgRate = totalCreated > 0 ? (totalCompleted / totalCreated * 100) : 0.0;

      return Right(MonthlyStatsEntity(
        averageCompletionRate: avgRate,
        totalTasksCompleted: totalCompleted,
        totalTasksCreated: totalCreated,
        bestStreakDays: bestStreak,
        currentStreakDays: currentStreak,
        dailyCompletionRates: dailyRates,
      ));
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }
}

class _DayData {
  int total;
  int completed;
  final String label;
  final bool isFuture;
  _DayData({required this.total, required this.completed, required this.label, required this.isFuture});
}