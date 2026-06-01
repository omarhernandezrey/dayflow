import '../../domain/entities/task.dart';

class TaskModel {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String time;
  final int reminderMinutes;
  final int completed;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.reminderMinutes,
    required this.completed,
  });

  factory TaskModel.fromEntity(TaskEntity entity) => TaskModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        category: entity.category.value,
        date: entity.date,
        time: entity.time,
        reminderMinutes: entity.reminderMinutes,
        completed: entity.completed ? 1 : 0,
      );

  TaskEntity toEntity() => TaskEntity(
        id: id,
        title: title,
        description: description,
        category: TaskCategory.fromString(category),
        date: date,
        time: time,
        reminderMinutes: reminderMinutes,
        completed: completed == 1,
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'title': title,
        'description': description,
        'category': category,
        'date': date,
        'time': time,
        'reminder_minutes': reminderMinutes,
        'completed': completed,
      };

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        id: map['id'] as int?,
        title: map['title'] as String,
        description: (map['description'] as String?) ?? '',
        category: (map['category'] as String?) ?? 'personal',
        date: map['date'] as String,
        time: map['time'] as String,
        reminderMinutes: (map['reminder_minutes'] as int?) ?? 15,
        completed: (map['completed'] as int?) ?? 0,
      );

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? date,
    String? time,
    int? reminderMinutes,
    int? completed,
  }) =>
      TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        date: date ?? this.date,
        time: time ?? this.time,
        reminderMinutes: reminderMinutes ?? this.reminderMinutes,
        completed: completed ?? this.completed,
      );

}
