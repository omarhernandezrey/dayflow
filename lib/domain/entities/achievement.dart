import 'package:equatable/equatable.dart';

class AchievementEntity extends Equatable {
  final int? id;
  final String key;
  final String title;
  final String description;
  final String icon;
  final DateTime? unlockedAt;
  final int progress;
  final int target;

  const AchievementEntity({
    this.id,
    required this.key,
    required this.title,
    required this.description,
    required this.icon,
    this.unlockedAt,
    this.progress = 0,
    required this.target,
  });

  bool get isUnlocked => unlockedAt != null;

  double get completionPercentage =>
      target > 0 ? (progress / target).clamp(0.0, 1.0) : 0.0;

  AchievementEntity copyWith({
    int? id,
    String? key,
    String? title,
    String? description,
    String? icon,
    DateTime? unlockedAt,
    int? progress,
    int? target,
  }) =>
      AchievementEntity(
        id: id ?? this.id,
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        unlockedAt: unlockedAt ?? this.unlockedAt,
        progress: progress ?? this.progress,
        target: target ?? this.target,
      );

  @override
  List<Object?> get props =>
      [id, key, title, description, icon, unlockedAt, progress, target];
}
