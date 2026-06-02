import 'package:equatable/equatable.dart';

enum TaskCategory {
  personal,
  academic,
  health;

  String get value {
    switch (this) {
      case TaskCategory.personal:
        return 'personal';
      case TaskCategory.academic:
        return 'academic';
      case TaskCategory.health:
        return 'health';
    }
  }

  String get label {
    switch (this) {
      case TaskCategory.personal:
        return 'Personal';
      case TaskCategory.academic:
        return 'Académica';
      case TaskCategory.health:
        return 'Salud';
    }
  }

  static TaskCategory fromString(String v) {
    switch (v) {
      case 'academic':
        return TaskCategory.academic;
      case 'health':
        return TaskCategory.health;
      default:
        return TaskCategory.personal;
    }
  }
}

class TaskEntity extends Equatable {
  final int? id;
  final String title;
  final String description;
  final TaskCategory category;
  final String date; // ISO 'YYYY-MM-DD'
  final String time; // 'HH:mm'
  final int reminderMinutes;
  final bool completed;

  const TaskEntity({
    this.id,
    required this.title,
    this.description = '',
    required this.category,
    required this.date,
    required this.time,
    this.reminderMinutes = 15,
    this.completed = false,
  });

  TaskEntity copyWith({
    int? id,
    String? title,
    String? description,
    TaskCategory? category,
    String? date,
    String? time,
    int? reminderMinutes,
    bool? completed,
  }) =>
      TaskEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        date: date ?? this.date,
        time: time ?? this.time,
        reminderMinutes: reminderMinutes ?? this.reminderMinutes,
        completed: completed ?? this.completed,
      );

  DateTime? get scheduledDateTime {
    try {
      final d = date.split('-');
      final t = time.split(':');
      return DateTime(
        int.parse(d[0]),
        int.parse(d[1]),
        int.parse(d[2]),
        int.parse(t[0]),
        int.parse(t[1]),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  List<Object?> get props =>
      [id, title, description, category, date, time, reminderMinutes, completed];
}
