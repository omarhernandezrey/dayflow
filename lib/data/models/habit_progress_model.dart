import '../../domain/entities/habit_progress.dart';

class HabitProgressModel {
  final int? id;
  final int habitId;
  final String date;
  final double currentValue;
  final double targetValue;
  final String unit;

  HabitProgressModel({
    this.id,
    required this.habitId,
    required this.date,
    required this.currentValue,
    required this.targetValue,
    required this.unit,
  });

  factory HabitProgressModel.fromEntity(HabitProgressEntity entity) =>
      HabitProgressModel(
        id: entity.id,
        habitId: entity.habitId,
        date: entity.date,
        currentValue: entity.currentValue,
        targetValue: entity.targetValue,
        unit: entity.unit,
      );

  HabitProgressEntity toEntity() => HabitProgressEntity(
        id: id,
        habitId: habitId,
        date: date,
        currentValue: currentValue,
        targetValue: targetValue,
        unit: unit,
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'habit_id': habitId,
        'date': date,
        'current_value': currentValue,
        'target_value': targetValue,
        'unit': unit,
      };

  factory HabitProgressModel.fromMap(Map<String, dynamic> map) =>
      HabitProgressModel(
        id: map['id'] as int?,
        habitId: map['habit_id'] as int,
        date: map['date'] as String,
        currentValue: (map['current_value'] as num?)?.toDouble() ?? 0.0,
        targetValue: (map['target_value'] as num?)?.toDouble() ?? 1.0,
        unit: (map['unit'] as String?) ?? 'count',
      );

  HabitProgressModel copyWith({
    int? id,
    int? habitId,
    String? date,
    double? currentValue,
    double? targetValue,
    String? unit,
  }) =>
      HabitProgressModel(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        date: date ?? this.date,
        currentValue: currentValue ?? this.currentValue,
        targetValue: targetValue ?? this.targetValue,
        unit: unit ?? this.unit,
      );
}
