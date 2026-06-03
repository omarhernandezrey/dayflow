import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/home_widget_service.dart';
import '../../core/utils/df_date_utils.dart';
import '../providers/habits_provider.dart';
import '../providers/tasks_provider.dart';

/// Debounced home widget updater — waits 500ms after the last change
/// before pushing an update to avoid redundant calls during rapid state changes.
final homeWidgetUpdaterProvider = Provider<void>((ref) {
  final tasksAsync = ref.watch(tasksProvider);
  final progressAsync = ref.watch(todayProgressProvider);

  final timer = Timer(const Duration(milliseconds: 500), () {
    tasksAsync.whenData((tasks) {
      final todayStr = DFDateUtils.isoDate(DateTime.now());

      final pendingToday = tasks.where((t) => t.date == todayStr && !t.completed).toList()
        ..sort((a, b) => a.time.compareTo(b.time));

      final nextTask = pendingToday.isNotEmpty ? pendingToday.first : null;

      int completedHabits = 0;
      int totalHabits = 0;
      progressAsync.whenData((progressMap) {
        completedHabits = progressMap.values.where((p) => p.isCompleted).length;
        totalHabits = progressMap.length;
      });

      try {
        HomeWidgetService.update(
          pendingTasks: pendingToday.length,
          completedHabits: completedHabits,
          totalHabits: totalHabits,
          nextTaskTitle: nextTask?.title ?? 'Sin tareas pendientes',
          nextTaskTime: nextTask?.time ?? '',
        );
      } catch (_) {}
    });
  });

  ref.onDispose(timer.cancel);

  return;
});