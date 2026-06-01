import 'package:equatable/equatable.dart';

class DailySummaryEntity extends Equatable {
  final int totalActivities;
  final int completedActivities;
  final int pendingActivities;
  final int totalHabits;
  final int completedHabits;
  final double overallCompletionRate;

  const DailySummaryEntity({
    this.totalActivities = 0,
    this.completedActivities = 0,
    this.pendingActivities = 0,
    this.totalHabits = 0,
    this.completedHabits = 0,
    this.overallCompletionRate = 0.0,
  });

  int get incompleteActivities => totalActivities - completedActivities;

  DailySummaryEntity copyWith({
    int? totalActivities,
    int? completedActivities,
    int? pendingActivities,
    int? totalHabits,
    int? completedHabits,
    double? overallCompletionRate,
  }) =>
      DailySummaryEntity(
        totalActivities: totalActivities ?? this.totalActivities,
        completedActivities: completedActivities ?? this.completedActivities,
        pendingActivities: pendingActivities ?? this.pendingActivities,
        totalHabits: totalHabits ?? this.totalHabits,
        completedHabits: completedHabits ?? this.completedHabits,
        overallCompletionRate: overallCompletionRate ?? this.overallCompletionRate,
      );

  @override
  List<Object?> get props => [
        totalActivities,
        completedActivities,
        pendingActivities,
        totalHabits,
        completedHabits,
        overallCompletionRate,
      ];
}
