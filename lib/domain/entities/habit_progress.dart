import 'package:equatable/equatable.dart';

class HabitProgressEntity extends Equatable {
  final int? id;
  final int habitId;
  final String date;
  final double currentValue;
  final double targetValue;
  final String unit;

  const HabitProgressEntity({
    this.id,
    required this.habitId,
    required this.date,
    this.currentValue = 0.0,
    this.targetValue = 1.0,
    this.unit = 'count',
  });

  double get percentage => targetValue > 0
      ? (currentValue / targetValue).clamp(0.0, 1.0)
      : 0.0;

  bool get isCompleted => currentValue >= targetValue;

  HabitProgressEntity copyWith({
    int? id,
    int? habitId,
    String? date,
    double? currentValue,
    double? targetValue,
    String? unit,
  }) =>
      HabitProgressEntity(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        date: date ?? this.date,
        currentValue: currentValue ?? this.currentValue,
        targetValue: targetValue ?? this.targetValue,
        unit: unit ?? this.unit,
      );

  @override
  List<Object?> get props =>
      [id, habitId, date, currentValue, targetValue, unit];
}
