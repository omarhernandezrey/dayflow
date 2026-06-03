import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/habits/add_habit.dart';
import '../../domain/usecases/habits/delete_habit.dart';
import '../../domain/usecases/habits/get_habit_streak.dart';
import '../../domain/usecases/habits/get_habits.dart';
import '../../domain/usecases/habits/increment_habit_progress.dart';
import '../../domain/usecases/habits/update_habit.dart';
import 'repository_providers.dart';

final getAllHabitsUseCaseProvider = Provider((ref) => GetAllHabitsUseCase(ref.watch(habitRepositoryProvider)));
final addHabitUseCaseProvider = Provider((ref) => AddHabitUseCase(ref.watch(habitRepositoryProvider)));
final updateHabitUseCaseProvider = Provider((ref) => UpdateHabitUseCase(ref.watch(habitRepositoryProvider)));
final deleteHabitUseCaseProvider = Provider((ref) => DeleteHabitUseCase(ref.watch(habitRepositoryProvider)));
final incrementHabitProgressUseCaseProvider = Provider((ref) => IncrementHabitProgressUseCase(ref.watch(habitRepositoryProvider)));
final getHabitStreakUseCaseProvider = Provider((ref) => GetHabitStreakUseCase(ref.watch(habitRepositoryProvider)));
final getGlobalStreakUseCaseProvider = Provider((ref) => GetGlobalStreakUseCase(ref.watch(habitRepositoryProvider)));