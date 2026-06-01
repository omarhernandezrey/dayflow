import 'package:equatable/equatable.dart';

class DayBarEntity extends Equatable {
  final String day;
  final double value;
  final bool isFuture;

  const DayBarEntity({
    required this.day,
    required this.value,
    this.isFuture = false,
  });

  @override
  List<Object?> get props => [day, value, isFuture];
}

class WeeklyStatsEntity extends Equatable {
  final double completionPercentage;
  final int completedTasks;
  final int pendingTasks;
  final int totalTasks;
  final int completedHabits;
  final int totalHabits;
  final List<DayBarEntity> dayBars;

  const WeeklyStatsEntity({
    this.completionPercentage = 0.0,
    this.completedTasks = 0,
    this.pendingTasks = 0,
    this.totalTasks = 0,
    this.completedHabits = 0,
    this.totalHabits = 0,
    this.dayBars = const [],
  });

  int get skippedTasks => (totalTasks - completedTasks - pendingTasks).clamp(0, totalTasks);

  WeeklyStatsEntity copyWith({
    double? completionPercentage,
    int? completedTasks,
    int? pendingTasks,
    int? totalTasks,
    int? completedHabits,
    int? totalHabits,
    List<DayBarEntity>? dayBars,
  }) =>
      WeeklyStatsEntity(
        completionPercentage: completionPercentage ?? this.completionPercentage,
        completedTasks: completedTasks ?? this.completedTasks,
        pendingTasks: pendingTasks ?? this.pendingTasks,
        totalTasks: totalTasks ?? this.totalTasks,
        completedHabits: completedHabits ?? this.completedHabits,
        totalHabits: totalHabits ?? this.totalHabits,
        dayBars: dayBars ?? this.dayBars,
      );

  @override
  List<Object?> get props => [
        completionPercentage,
        completedTasks,
        pendingTasks,
        totalTasks,
        completedHabits,
        totalHabits,
        dayBars,
      ];
}
