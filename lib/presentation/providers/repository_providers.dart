import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/achievement_repository_impl.dart';
import '../../data/repositories/backup_repository_impl.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/stats_repository_impl.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/achievement_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../domain/repositories/task_repository.dart';
import 'datasource_providers.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(
    ref.watch(localDatabaseProvider),
    ref.watch(notificationRepositoryProvider),
  );
});

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepositoryImpl(ref.watch(localDatabaseProvider));
});

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  return StatsRepositoryImpl(ref.watch(localDatabaseProvider));
});

final achievementRepositoryProvider = Provider<AchievementRepository>((ref) {
  return AchievementRepositoryImpl(ref.watch(localDatabaseProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(localDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.watch(localDatabaseProvider));
});

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return BackupRepositoryImpl(
    ref.watch(localDatabaseProvider),
    ref.watch(fileDatasourceProvider),
  );
});