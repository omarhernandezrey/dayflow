import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_progress.dart';
import 'dependency_providers.dart';

final habitsProvider = AsyncNotifierProvider<HabitsNotifier, List<HabitEntity>>(HabitsNotifier.new);

class HabitsNotifier extends AsyncNotifier<List<HabitEntity>> {
  @override
  Future<List<HabitEntity>> build() async {
    final useCase = ref.read(getAllHabitsUseCaseProvider);
    final result = await useCase.call();
    return result.getOrElse(() => []);
  }

  Future<void> add(HabitEntity habit) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(addHabitUseCaseProvider);
    final result = await useCase.call(habit);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> edit(HabitEntity habit) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(updateHabitUseCaseProvider);
    final result = await useCase.call(habit);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> delete(int id) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(deleteHabitUseCaseProvider);
    final result = await useCase.call(id);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> _refresh() async {
    final useCase = ref.read(getAllHabitsUseCaseProvider);
    final result = await useCase.call();
    state = AsyncValue.data(result.getOrElse(() => []));
  }
}

// Today's progress map
final todayProgressProvider =
    AsyncNotifierProvider<TodayProgressNotifier, Map<int, HabitProgressEntity>>(
        TodayProgressNotifier.new);

class TodayProgressNotifier extends AsyncNotifier<Map<int, HabitProgressEntity>> {
  @override
  Future<Map<int, HabitProgressEntity>> build() async {
    final repo = ref.read(habitRepositoryProvider);
    final today = _isoDate(DateTime.now());
    final result = await repo.getAllProgressForDate(today);
    return result.getOrElse(() => {});
  }

  Future<void> increment(int habitId, double amount) async {
    final useCase = ref.read(incrementHabitProgressUseCaseProvider);
    final today = _isoDate(DateTime.now());
    final result = await useCase.call(habitId: habitId, date: today, amount: amount);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> _refresh() async {
    final repo = ref.read(habitRepositoryProvider);
    final today = _isoDate(DateTime.now());
    final result = await repo.getAllProgressForDate(today);
    state = AsyncValue.data(result.getOrElse(() => {}));
  }

  static String _isoDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

// Global streak
final globalStreakProvider = FutureProvider<int>((ref) async {
  ref.watch(todayProgressProvider);
  final useCase = ref.read(getGlobalStreakUseCaseProvider);
  final result = await useCase.call();
  return result.getOrElse(() => 0);
});

// Individual habit streak
final habitStreakProvider = FutureProvider.family<int, int>((ref, habitId) async {
  ref.watch(todayProgressProvider);
  final useCase = ref.read(getHabitStreakUseCaseProvider);
  final result = await useCase.call(habitId);
  return result.getOrElse(() => 0);
});
