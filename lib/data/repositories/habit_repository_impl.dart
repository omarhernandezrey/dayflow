import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_progress.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/local_database.dart';
import '../models/habit_model.dart';
import '../models/habit_progress_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final LocalDatabase _db;

  HabitRepositoryImpl(this._db);

  @override
  Future<Either<Failure, List<HabitEntity>>> getAllHabits() async {
    try {
      final rows = await _db.queryHabits();
      return Right(rows.map((r) => HabitModel.fromMap(r).toEntity()).toList());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, HabitEntity>> getHabitById(int id) async {
    try {
      final rows = await _db.queryHabits();
      final row = rows.cast<Map<String, dynamic>?>().firstWhere(
            (r) => r != null && r['id'] == id,
            orElse: () => null,
          );
      if (row == null) return const Left(NotFoundFailure('Hábito no encontrado'));
      return Right(HabitModel.fromMap(row).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, HabitEntity>> createHabit(HabitEntity habit) async {
    try {
      final model = HabitModel.fromEntity(habit);
      final id = await _db.insertHabit(model.toMap()..remove('id'));
      return Right(model.copyWith(id: id).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, HabitEntity>> updateHabit(HabitEntity habit) async {
    try {
      if (habit.id == null) {
        return const Left(ValidationFailure('El hábito no tiene ID'));
      }
      final model = HabitModel.fromEntity(habit);
      await _db.updateHabit(model.toMap(), habit.id!);
      return Right(habit);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHabit(int id) async {
    try {
      await _db.deleteHabit(id);
      return const Right(null);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, HabitProgressEntity>> getProgressForDate(int habitId, String date) async {
    try {
      final rows = await _db.queryHabitProgress(
        where: 'habit_id = ? AND date = ?',
        whereArgs: [habitId, date],
      );
      if (rows.isEmpty) {
        return Right(HabitProgressEntity(habitId: habitId, date: date));
      }
      return Right(HabitProgressModel.fromMap(rows.first).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, Map<int, HabitProgressEntity>>> getAllProgressForDate(String date) async {
    try {
      final rows = await _db.queryHabitProgress(where: 'date = ?', whereArgs: [date]);
      final map = <int, HabitProgressEntity>{};
      for (final row in rows) {
        final p = HabitProgressModel.fromMap(row);
        map[p.habitId] = p.toEntity();
      }
      return Right(map);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, HabitProgressEntity>> incrementProgress(
    int habitId,
    String date,
    double amount,
  ) async {
    try {
      final existing = await getProgressForDate(habitId, date);
      double current = 0;
      double target = 1;
      String unit = 'count';
      existing.fold((_) {}, (p) {
        current = p.currentValue;
        target = p.targetValue;
        unit = p.unit;
      });

      // Fetch habit to get its goal/target if no progress exists yet
      if (current == 0) {
        final habitResult = await getHabitById(habitId);
        habitResult.fold((_) {}, (h) {
          target = h.goal;
          unit = h.unit;
        });
      }

      final newValue = current + amount;
      final model = HabitProgressModel(
        habitId: habitId,
        date: date,
        currentValue: newValue,
        targetValue: target,
        unit: unit,
      );
      await _db.insertOrReplaceHabitProgress(model.toMap()..remove('id'));
      return Right(model.copyWith(id: 0).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, HabitProgressEntity>> setProgress(
    int habitId,
    String date,
    double currentValue,
  ) async {
    try {
      double target = 1;
      String unit = 'count';
      final habitResult = await getHabitById(habitId);
      habitResult.fold((_) {}, (h) {
        target = h.goal;
        unit = h.unit;
      });

      final model = HabitProgressModel(
        habitId: habitId,
        date: date,
        currentValue: currentValue,
        targetValue: target,
        unit: unit,
      );
      await _db.insertOrReplaceHabitProgress(model.toMap()..remove('id'));
      return Right(model.copyWith(id: 0).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, int>> getHabitStreak(int habitId) async {
    try {
      final today = DateTime.now();
      final maxDays = 365;
      final startDate = _isoDate(today.subtract(Duration(days: maxDays)));
      final endDate = _isoDate(today);

      final rows = await _db.rawQuery(
        'SELECT DISTINCT date FROM habit_progress '
        'WHERE habit_id = ? AND date BETWEEN ? AND ? AND current_value >= target_value '
        'ORDER BY date DESC',
        [habitId, startDate, endDate],
      );

      final completedDates = rows.map((r) => r['date'] as String).toSet();
      int streak = 0;
      DateTime day = today;
      while (true) {
        final dateStr = _isoDate(day);
        if (completedDates.contains(dateStr)) {
          streak++;
          day = day.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }
      return Right(streak);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, int>> getGlobalStreak() async {
    try {
      final today = DateTime.now();
      final maxDays = 365;
      final startDate = _isoDate(today.subtract(Duration(days: maxDays)));
      final endDate = _isoDate(today);

      final rows = await _db.rawQuery(
        'SELECT DISTINCT date FROM habit_progress '
        'WHERE date BETWEEN ? AND ? AND current_value >= target_value '
        'ORDER BY date DESC',
        [startDate, endDate],
      );

      final completedDates = rows.map((r) => r['date'] as String).toSet();
      int streak = 0;
      DateTime day = today;
      while (true) {
        final dateStr = _isoDate(day);
        if (completedDates.contains(dateStr)) {
          streak++;
          day = day.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }
      return Right(streak);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  static String _isoDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
