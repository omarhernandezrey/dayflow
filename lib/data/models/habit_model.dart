import '../../domain/entities/habit.dart';

class HabitModel {
  final int? id;
  final String title;
  final String icon;
  final String colorHex;
  final String frequency;
  final String activeDays;
  final double goal;
  final String unit;

  HabitModel({
    this.id,
    required this.title,
    required this.icon,
    required this.colorHex,
    required this.frequency,
    required this.activeDays,
    required this.goal,
    required this.unit,
  });

  factory HabitModel.fromEntity(HabitEntity entity) => HabitModel(
        id: entity.id,
        title: entity.title,
        icon: entity.icon,
        colorHex: entity.colorHex,
        frequency: entity.frequency.value,
        activeDays: entity.activeDays,
        goal: entity.goal,
        unit: entity.unit,
      );

  HabitEntity toEntity() => HabitEntity(
        id: id,
        title: title,
        icon: icon,
        colorHex: colorHex,
        frequency: HabitFrequency.fromString(frequency),
        activeDays: activeDays,
        goal: goal,
        unit: unit,
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'title': title,
        'icon': icon,
        'color_hex': colorHex,
        'frequency': frequency,
        'active_days': activeDays,
        'goal': goal,
        'unit': unit,
      };

  factory HabitModel.fromMap(Map<String, dynamic> map) => HabitModel(
        id: map['id'] as int?,
        title: map['title'] as String,
        icon: (map['icon'] as String?) ?? 'water',
        colorHex: (map['color_hex'] as String?) ?? '#3D7BFF',
        frequency: (map['frequency'] as String?) ?? 'daily',
        activeDays: (map['active_days'] as String?) ?? '1111100',
        goal: (map['goal'] as num?)?.toDouble() ?? 1.0,
        unit: (map['unit'] as String?) ?? 'count',
      );

  bool isActiveOnDay(int weekday) {
    final idx = weekday - 1;
    if (idx < 0 || idx >= activeDays.length) return false;
    return activeDays[idx] == '1';
  }

  HabitModel copyWith({
    int? id,
    String? title,
    String? icon,
    String? colorHex,
    String? frequency,
    String? activeDays,
    double? goal,
    String? unit,
  }) =>
      HabitModel(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        colorHex: colorHex ?? this.colorHex,
        frequency: frequency ?? this.frequency,
        activeDays: activeDays ?? this.activeDays,
        goal: goal ?? this.goal,
        unit: unit ?? this.unit,
      );

}
