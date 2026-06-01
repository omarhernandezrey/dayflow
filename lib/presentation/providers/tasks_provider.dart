import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/task.dart';
import 'dependency_providers.dart';

// Filter state
final taskFilterProvider = StateProvider<TaskCategory?>((ref) => null);
final taskSearchQueryProvider = StateProvider<String>((ref) => '');

// All tasks
final tasksProvider = AsyncNotifierProvider<TasksNotifier, List<TaskEntity>>(TasksNotifier.new);

class TasksNotifier extends AsyncNotifier<List<TaskEntity>> {
  @override
  Future<List<TaskEntity>> build() async {
    final useCase = ref.read(getAllTasksUseCaseProvider);
    final result = await useCase.call();
    return result.getOrElse(() => []);
  }

  Future<void> add(TaskEntity task) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(addTaskUseCaseProvider);
    final result = await useCase.call(task);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> edit(TaskEntity task) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(updateTaskUseCaseProvider);
    final result = await useCase.call(task);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> delete(int id) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(deleteTaskUseCaseProvider);
    final result = await useCase.call(id);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> toggle(int id, bool completed) async {
    final useCase = ref.read(toggleTaskUseCaseProvider);
    final result = await useCase.call(id, completed);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> _refresh() async {
    final useCase = ref.read(getAllTasksUseCaseProvider);
    final result = await useCase.call();
    state = AsyncValue.data(result.getOrElse(() => []));
  }
}

// Derived: filtered by category
final filteredTasksProvider = Provider<AsyncValue<List<TaskEntity>>>((ref) {
  final filter = ref.watch(taskFilterProvider);
  final tasksAsync = ref.watch(tasksProvider);
  return tasksAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (tasks) {
      if (filter == null) return AsyncValue.data(tasks);
      return AsyncValue.data(tasks.where((t) => t.category == filter).toList());
    },
  );
});

// Derived: search results
final searchedTasksProvider = Provider<AsyncValue<List<TaskEntity>>>((ref) {
  final query = ref.watch(taskSearchQueryProvider);
  final tasksAsync = ref.watch(tasksProvider);
  if (query.trim().isEmpty) return tasksAsync;

  return tasksAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (tasks) {
      final lower = query.toLowerCase();
      return AsyncValue.data(tasks.where((t) {
        return t.title.toLowerCase().contains(lower) ||
            t.description.toLowerCase().contains(lower);
      }).toList());
    },
  );
});
