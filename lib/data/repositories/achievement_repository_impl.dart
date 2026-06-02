import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/repositories/achievement_repository.dart';
import '../datasources/local_database.dart';
import '../../core/utils/df_date_utils.dart';
import '../models/achievement_model.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  final LocalDatabase _db;

  AchievementRepositoryImpl(this._db);

  @override
  Future<Either<Failure, List<AchievementEntity>>> getAllAchievements() async {
    try {
      final rows = await _db.queryAchievements();
      return Right(rows.map((r) => AchievementModel.fromMap(r).toEntity()).toList());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, List<AchievementEntity>>> getUnlockedAchievements() async {
    try {
      final rows = await _db.queryAchievements();
      final achievements = rows
          .map((r) => AchievementModel.fromMap(r).toEntity())
          .where((a) => a.isUnlocked)
          .toList();
      return Right(achievements);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, List<AchievementEntity>>> checkAndUnlockAchievements() async {
    try {
      final rows = await _db.queryAchievements();
      final achievements = rows.map((r) => AchievementModel.fromMap(r)).toList();
      final unlocked = <AchievementEntity>[];

      for (final a in achievements) {
        if (a.unlockedAt != null) continue;

        final progress = await _calculateProgress(a.key);
        if (progress != a.progress) {
          await _db.insertOrReplaceAchievement(a.copyWith(progress: progress).toMap());
        }
        if (progress >= a.target) {
          final unlockedAt = DateTime.now().toIso8601String();
          await _db.insertOrReplaceAchievement(
            a.copyWith(progress: progress, unlockedAt: unlockedAt).toMap(),
          );
          unlocked.add(a.copyWith(progress: progress, unlockedAt: unlockedAt).toEntity());
        }
      }

      return Right(unlocked);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> seedAchievements() async {
    try {
      // Achievements are seeded on database creation
      return const Right(null);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  Future<int> _calculateProgress(String key) async {
    switch (key) {
      case 'first_task':
        final tasks = await _db.queryTasks(where: 'completed = ?', whereArgs: [1]);
        return tasks.isNotEmpty ? 1 : 0;
      case 'tasks_100':
        final tasks = await _db.queryTasks(where: 'completed = ?', whereArgs: [1]);
        return tasks.length;
      case 'planner':
        final tasks = await _db.queryTasks();
        return tasks.length;
      case 'habits_5':
        final habits = await _db.queryHabits();
        return habits.length;
      case 'streak_7':
      case 'streak_30':
        return await _calculateGlobalStreak();
      case 'perfect_week':
        return await _calculatePerfectWeeks();
      default:
        return 0;
    }
  }

  Future<int> _calculateGlobalStreak() async {
    int streak = 0;
    DateTime day = DateTime.now();
    while (true) {
      final dateStr = DFDateUtils.isoDate(day);
      final progress = await _db.queryHabitProgress(
        where: 'date = ? AND current_value >= target_value',
        whereArgs: [dateStr],
      );
      if (progress.isEmpty) break;
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  Future<int> _calculatePerfectWeeks() async {
    int perfectWeeks = 0;
    final now = DateTime.now();
    // Check last 4 weeks
    for (int w = 0; w < 4; w++) {
      final weekStart = now.subtract(Duration(days: now.weekday - 1 + w * 7));
      bool perfect = true;
      for (int i = 0; i < 7; i++) {
        final day = weekStart.add(Duration(days: i));
        if (day.isAfter(now)) continue;
        final dateStr = DFDateUtils.isoDate(day);
        final tasks = await _db.queryTasks(where: 'date = ?', whereArgs: [dateStr]);
        if (tasks.isNotEmpty && tasks.any((r) => r['completed'] == 0)) {
          perfect = false;
          break;
        }
      }
      if (perfect && weekStart.isBefore(now)) perfectWeeks++;
    }
    return perfectWeeks;
  }
}
