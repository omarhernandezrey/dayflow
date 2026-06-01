import '../../domain/entities/achievement.dart';

class AchievementModel {
  final int? id;
  final String key;
  final String title;
  final String description;
  final String icon;
  final String? unlockedAt;
  final int progress;
  final int target;

  AchievementModel({
    this.id,
    required this.key,
    required this.title,
    required this.description,
    required this.icon,
    this.unlockedAt,
    required this.progress,
    required this.target,
  });

  factory AchievementModel.fromEntity(AchievementEntity entity) =>
      AchievementModel(
        id: entity.id,
        key: entity.key,
        title: entity.title,
        description: entity.description,
        icon: entity.icon,
        unlockedAt: entity.unlockedAt?.toIso8601String(),
        progress: entity.progress,
        target: entity.target,
      );

  AchievementEntity toEntity() => AchievementEntity(
        id: id,
        key: key,
        title: title,
        description: description,
        icon: icon,
        unlockedAt: unlockedAt != null ? DateTime.tryParse(unlockedAt!) : null,
        progress: progress,
        target: target,
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'key': key,
        'title': title,
        'description': description,
        'icon': icon,
        'unlocked_at': unlockedAt,
        'progress': progress,
        'target': target,
      };

  factory AchievementModel.fromMap(Map<String, dynamic> map) => AchievementModel(
        id: map['id'] as int?,
        key: map['key'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        icon: map['icon'] as String,
        unlockedAt: map['unlocked_at'] as String?,
        progress: (map['progress'] as int?) ?? 0,
        target: (map['target'] as int?) ?? 1,
      );

  AchievementModel copyWith({
    int? id,
    String? key,
    String? title,
    String? description,
    String? icon,
    String? unlockedAt,
    int? progress,
    int? target,
  }) =>
      AchievementModel(
        id: id ?? this.id,
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        unlockedAt: unlockedAt ?? this.unlockedAt,
        progress: progress ?? this.progress,
        target: target ?? this.target,
      );
}
