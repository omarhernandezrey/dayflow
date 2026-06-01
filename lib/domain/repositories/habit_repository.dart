import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/habit.dart';
import '../entities/habit_progress.dart';

abstract class HabitRepository {
  Future<Either<Failure, List<HabitEntity>>> getAllHabits();
  Future<Either<Failure, HabitEntity>> getHabitById(int id);
  Future<Either<Failure, HabitEntity>> createHabit(HabitEntity habit);
  Future<Either<Failure, HabitEntity>> updateHabit(HabitEntity habit);
  Future<Either<Failure, void>> deleteHabit(int id);

  Future<Either<Failure, HabitProgressEntity>> getProgressForDate(int habitId, String date);
  Future<Either<Failure, Map<int, HabitProgressEntity>>> getAllProgressForDate(String date);
  Future<Either<Failure, HabitProgressEntity>> incrementProgress(
    int habitId,
    String date,
    double amount,
  );
  Future<Either<Failure, HabitProgressEntity>> setProgress(
    int habitId,
    String date,
    double currentValue,
  );

  Future<Either<Failure, int>> getHabitStreak(int habitId);
  Future<Either<Failure, int>> getGlobalStreak();
}
