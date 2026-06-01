import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/daily_summary.dart';
import '../entities/monthly_stats.dart';
import '../entities/weekly_stats.dart';

abstract class StatsRepository {
  Future<Either<Failure, DailySummaryEntity>> getTodayStats();
  Future<Either<Failure, WeeklyStatsEntity>> getWeeklyStats();
  Future<Either<Failure, MonthlyStatsEntity>> getMonthlyStats(int year, int month);
}
