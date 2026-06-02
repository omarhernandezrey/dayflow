import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dayflow/core/errors/failures.dart';
import 'package:dayflow/domain/entities/habit.dart';
import 'package:dayflow/domain/entities/habit_progress.dart';
import 'package:dayflow/domain/entities/task.dart';
import 'package:dayflow/domain/entities/user.dart';
import 'package:dayflow/domain/repositories/auth_repository.dart';
import 'package:dayflow/domain/repositories/habit_repository.dart';
import 'package:dayflow/domain/repositories/task_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTaskRepository extends Mock implements TaskRepository {}

class MockHabitRepository extends Mock implements HabitRepository {}

class MockLocalDatabase extends Mock
    implements MockLocalDatabaseInterface {}

abstract class MockLocalDatabaseInterface {
  Future<List<Map<String, dynamic>>> queryTasks({
    String? where,
    List<dynamic>? whereArgs,
  });
  Future<List<Map<String, dynamic>>> queryHabits();
  Future<List<Map<String, dynamic>>> queryHabitProgress({
    String? where,
    List<dynamic>? whereArgs,
  });
  Future<List<Map<String, dynamic>>> queryUsers({
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<int> insertUser(Map<String, dynamic> map);
  Future<void> insertOrReplaceHabitProgress(Map<String, dynamic> map);
  Future<List<Map<String, dynamic>>> rawQuery(
      String sql, List<dynamic>? args);
}

void registerFallbacks() {
  registerFallbackValue(TaskCategory.personal);
  registerFallbackValue(HabitFrequency.daily);
  registerFallbackValue(const TaskEntity(
    title: '',
    category: TaskCategory.personal,
    date: '2024-01-01',
    time: '00:00',
  ));
  registerFallbackValue(const HabitEntity(title: ''));
  registerFallbackValue(ValidationFailure(''));
  registerFallbackValue(const HabitProgressEntity(
    habitId: 1,
    date: '2024-01-01',
    currentValue: 0,
    targetValue: 1,
  ));
}