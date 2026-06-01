import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/daily_summary.dart';
import '../../domain/entities/monthly_stats.dart';
import '../../domain/entities/weekly_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/local_database.dart';
import '../models/habit_model.dart';

class StatsRepositoryImpl implements StatsRepository {
  final LocalDatabase _db;

  StatsRepositoryImpl(this._db);

  @override
  Future<Either<Failure, DailySummaryEntity>> getTodayStats() async {
    try {
      final today = _isoDate(DateTime.now());

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
      final weekStart = _startOfWeek(now);

      int totalTasks = 0;
      int completedTasks = 0;
      final List<DayBarEntity> bars = [];

      for (int i = 0; i < 7; i++) {
        final day = weekStart.add(Duration(days: i));
        final dateStr = _isoDate(day);
        final all = await _db.queryTasks(where: 'date = ?', whereArgs: [dateStr]);
        final done = all.where((r) => r['completed'] == 1).length;

        totalTasks += all.length;
        completedTasks += done;

        final pct = all.isEmpty ? 0.0 : (done / all.length * 100);
        bars.add(DayBarEntity(
          day: _dayLabel(day.weekday),
          value: pct,
          isFuture: day.isAfter(now),
        ));
      }

      final completionPct = totalTasks == 0 ? 0.0 : (completedTasks / totalTasks * 100);

      // Habit weekly stats
      final habitRows = await _db.queryHabits();
      int totalChecks = 0;
      int completedChecks = 0;
      for (final row in habitRows) {
        final h = HabitModel.fromMap(row);
        for (int i = 0; i < 7; i++) {
          final day = weekStart.add(Duration(days: i));
          if (h.isActiveOnDay(day.weekday)) {
            totalChecks++;
            final dateStr = _isoDate(day);
            final rows = await _db.queryHabitProgress(
              where: 'habit_id = ? AND date = ? AND current_value >= target_value',
              whereArgs: [h.id, dateStr],
            );
            if (rows.isNotEmpty) completedChecks++;
          }
        }
      }

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
      int totalCompleted = 0;
      int totalCreated = 0;
      int bestStreak = 0;
      int currentStreak = 0;
      int tempStreak = 0;
      final dailyRates = <int, double>{};

      for (int day = 1; day <= daysInMonth; day++) {
        final dateStr = '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
        final tasks = await _db.queryTasks(where: 'date = ?', whereArgs: [dateStr]);
        final created = tasks.length;
        final completed = tasks.where((r) => r['completed'] == 1).length;

        totalCreated += created;
        totalCompleted += completed;
        dailyRates[day] = created > 0 ? (completed / created * 100) : 0.0;

        if (created > 0 && completed == created) {
          tempStreak++;
          bestStreak = tempStreak > bestStreak ? tempStreak : bestStreak;
        } else {
          tempStreak = 0;
        }
      }

      // Calculate current streak from today backwards
      DateTime checkDay = DateTime.now();
      while (checkDay.year == year && checkDay.month == month) {
        final dateStr = _isoDate(checkDay);
        final tasks = await _db.queryTasks(where: 'date = ?', whereArgs: [dateStr]);
        if (tasks.isNotEmpty && tasks.every((r) => r['completed'] == 1)) {
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

  static String _isoDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static DateTime _startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return DateTime(date.year, date.month, date.day - (weekday - 1));
  }

  static String _dayLabel(int weekday) {
    const labels = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return labels[weekday - 1];
  }
}
