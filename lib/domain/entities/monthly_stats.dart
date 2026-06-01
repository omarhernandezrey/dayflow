import 'package:equatable/equatable.dart';

class MonthlyStatsEntity extends Equatable {
  final double averageCompletionRate;
  final int totalTasksCompleted;
  final int totalTasksCreated;
  final int bestStreakDays;
  final int currentStreakDays;
  final Map<int, double> dailyCompletionRates; // day of month -> percentage

  const MonthlyStatsEntity({
    this.averageCompletionRate = 0.0,
    this.totalTasksCompleted = 0,
    this.totalTasksCreated = 0,
    this.bestStreakDays = 0,
    this.currentStreakDays = 0,
    this.dailyCompletionRates = const {},
  });

  MonthlyStatsEntity copyWith({
    double? averageCompletionRate,
    int? totalTasksCompleted,
    int? totalTasksCreated,
    int? bestStreakDays,
    int? currentStreakDays,
    Map<int, double>? dailyCompletionRates,
  }) =>
      MonthlyStatsEntity(
        averageCompletionRate: averageCompletionRate ?? this.averageCompletionRate,
        totalTasksCompleted: totalTasksCompleted ?? this.totalTasksCompleted,
        totalTasksCreated: totalTasksCreated ?? this.totalTasksCreated,
        bestStreakDays: bestStreakDays ?? this.bestStreakDays,
        currentStreakDays: currentStreakDays ?? this.currentStreakDays,
        dailyCompletionRates: dailyCompletionRates ?? this.dailyCompletionRates,
      );

  @override
  List<Object?> get props => [
        averageCompletionRate,
        totalTasksCompleted,
        totalTasksCreated,
        bestStreakDays,
        currentStreakDays,
        dailyCompletionRates,
      ];
}
