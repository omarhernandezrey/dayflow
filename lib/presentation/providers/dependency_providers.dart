import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/file_datasource.dart';
import '../../data/datasources/local_database_impl.dart';
import '../../data/repositories/achievement_repository_impl.dart';
import '../../data/repositories/backup_repository_impl.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../data/repositories/notification_repository_impl.dart';
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
import '../../domain/usecases/achievements/get_achievements.dart';
import '../../domain/usecases/auth/get_current_user.dart';
import '../../domain/usecases/auth/get_most_recent_user.dart';
import '../../domain/usecases/auth/is_authenticated.dart';
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/auth/logout.dart';
import '../../domain/usecases/auth/register.dart';
import '../../domain/usecases/backup/backup_usecases.dart';
import '../../domain/usecases/habits/add_habit.dart';
import '../../domain/usecases/habits/delete_habit.dart';
import '../../domain/usecases/habits/get_habit_streak.dart';
import '../../domain/usecases/habits/get_habits.dart';
import '../../domain/usecases/habits/increment_habit_progress.dart';
import '../../domain/usecases/habits/update_habit.dart';
import '../../domain/usecases/stats/get_monthly_stats.dart';
import '../../domain/usecases/stats/get_today_stats.dart';
import '../../domain/usecases/stats/get_weekly_stats.dart';
import '../../domain/usecases/tasks/add_task.dart';
import '../../domain/usecases/tasks/delete_task.dart';
import '../../domain/usecases/tasks/get_tasks.dart';
import '../../domain/usecases/tasks/search_tasks.dart';
import '../../domain/usecases/tasks/toggle_task.dart';
import '../../domain/usecases/tasks/update_task.dart';

// ─── Datasources ──────────────────────────────────────────────
final localDatabaseProvider = Provider((ref) => LocalDatabaseImpl());
final fileDatasourceProvider = Provider((ref) => FileDatasource());
final notificationRepositoryProvider = Provider((ref) => NotificationRepositoryImpl());

// ─── Repositories ─────────────────────────────────────────────
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

// ─── Use Cases ────────────────────────────────────────────────
final getAllTasksUseCaseProvider = Provider((ref) => GetAllTasksUseCase(ref.watch(taskRepositoryProvider)));
final addTaskUseCaseProvider = Provider((ref) => AddTaskUseCase(ref.watch(taskRepositoryProvider)));
final updateTaskUseCaseProvider = Provider((ref) => UpdateTaskUseCase(ref.watch(taskRepositoryProvider)));
final deleteTaskUseCaseProvider = Provider((ref) => DeleteTaskUseCase(ref.watch(taskRepositoryProvider)));
final toggleTaskUseCaseProvider = Provider((ref) => ToggleTaskUseCase(ref.watch(taskRepositoryProvider)));
final searchTasksUseCaseProvider = Provider((ref) => SearchTasksUseCase(ref.watch(taskRepositoryProvider)));

final getAllHabitsUseCaseProvider = Provider((ref) => GetAllHabitsUseCase(ref.watch(habitRepositoryProvider)));
final addHabitUseCaseProvider = Provider((ref) => AddHabitUseCase(ref.watch(habitRepositoryProvider)));
final updateHabitUseCaseProvider = Provider((ref) => UpdateHabitUseCase(ref.watch(habitRepositoryProvider)));
final deleteHabitUseCaseProvider = Provider((ref) => DeleteHabitUseCase(ref.watch(habitRepositoryProvider)));
final incrementHabitProgressUseCaseProvider = Provider((ref) => IncrementHabitProgressUseCase(ref.watch(habitRepositoryProvider)));
final getHabitStreakUseCaseProvider = Provider((ref) => GetHabitStreakUseCase(ref.watch(habitRepositoryProvider)));
final getGlobalStreakUseCaseProvider = Provider((ref) => GetGlobalStreakUseCase(ref.watch(habitRepositoryProvider)));

final getTodayStatsUseCaseProvider = Provider((ref) => GetTodayStatsUseCase(ref.watch(statsRepositoryProvider)));
final getWeeklyStatsUseCaseProvider = Provider((ref) => GetWeeklyStatsUseCase(ref.watch(statsRepositoryProvider)));
final getMonthlyStatsUseCaseProvider = Provider((ref) => GetMonthlyStatsUseCase(ref.watch(statsRepositoryProvider)));

final getAchievementsUseCaseProvider = Provider((ref) => GetAchievementsUseCase(ref.watch(achievementRepositoryProvider)));
final checkAchievementsUseCaseProvider = Provider((ref) => CheckAchievementsUseCase(ref.watch(achievementRepositoryProvider)));

final loginUseCaseProvider = Provider((ref) => LoginUseCase(ref.watch(authRepositoryProvider)));
final registerUseCaseProvider = Provider((ref) => RegisterUseCase(ref.watch(authRepositoryProvider)));
final logoutUseCaseProvider = Provider((ref) => LogoutUseCase(ref.watch(authRepositoryProvider)));
final getCurrentUserUseCaseProvider = Provider((ref) => GetCurrentUserUseCase(ref.watch(authRepositoryProvider)));
final getMostRecentUserUseCaseProvider = Provider((ref) => GetMostRecentUserUseCase(ref.watch(authRepositoryProvider)));
final isAuthenticatedUseCaseProvider = Provider((ref) => IsAuthenticatedUseCase(ref.watch(authRepositoryProvider)));

final exportToCsvUseCaseProvider = Provider((ref) => ExportToCsvUseCase(ref.watch(backupRepositoryProvider)));
final exportToPdfUseCaseProvider = Provider((ref) => ExportToPdfUseCase(ref.watch(backupRepositoryProvider)));
final createBackupUseCaseProvider = Provider((ref) => CreateBackupUseCase(ref.watch(backupRepositoryProvider)));
final restoreBackupUseCaseProvider = Provider((ref) => RestoreBackupUseCase(ref.watch(backupRepositoryProvider)));
