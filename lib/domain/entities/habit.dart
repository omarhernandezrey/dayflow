import 'package:equatable/equatable.dart';

enum HabitFrequency {
  daily,
  weekly,
  custom;

  String get value {
    switch (this) {
      case HabitFrequency.daily:
        return 'daily';
      case HabitFrequency.weekly:
        return 'weekly';
      case HabitFrequency.custom:
        return 'custom';
    }
  }

  String get label {
    switch (this) {
      case HabitFrequency.daily:
        return 'Diario';
      case HabitFrequency.weekly:
        return 'Semanal';
      case HabitFrequency.custom:
        return 'Personalizado';
    }
  }

  static HabitFrequency fromString(String v) {
    switch (v) {
      case 'weekly':
        return HabitFrequency.weekly;
      case 'custom':
        return HabitFrequency.custom;
      default:
        return HabitFrequency.daily;
    }
  }
}

class HabitEntity extends Equatable {
  final int? id;
  final String title;
  final String icon;
  final String colorHex;
  final HabitFrequency frequency;
  final String activeDays;
  final double goal;
  final String unit;

  const HabitEntity({
    this.id,
    required this.title,
    this.icon = 'water',
    this.colorHex = '#3D7BFF',
    this.frequency = HabitFrequency.daily,
    this.activeDays = '1111100',
    this.goal = 1.0,
    this.unit = 'count',
  });

  bool isActiveOnDay(int weekday) {
    final idx = weekday - 1;
    if (idx < 0 || idx >= activeDays.length) return false;
    return activeDays[idx] == '1';
  }

  HabitEntity copyWith({
    int? id,
    String? title,
    String? icon,
    String? colorHex,
    HabitFrequency? frequency,
    String? activeDays,
    double? goal,
    String? unit,
  }) =>
      HabitEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        colorHex: colorHex ?? this.colorHex,
        frequency: frequency ?? this.frequency,
        activeDays: activeDays ?? this.activeDays,
        goal: goal ?? this.goal,
        unit: unit ?? this.unit,
      );

  @override
  List<Object?> get props =>
      [id, title, icon, colorHex, frequency, activeDays, goal, unit];
}
