import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/task_category_ext.dart';
import '../../../core/utils/df_date_utils.dart';
import '../../../domain/entities/task.dart';
import '../../providers/celebration_provider.dart';
import '../../providers/tasks_provider.dart';
import '../../widgets/df_empty.dart';
import '../../widgets/df_error.dart';
import '../../widgets/df_loading.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  static const _filters = ['Todas', 'Personal', 'Académica', 'Salud'];
  static const _filterValues = [null, TaskCategory.personal, TaskCategory.academic, TaskCategory.health];

  @override
  Widget build(BuildContext context) {
    final currentFilter = ref.watch(taskFilterProvider);
    final filterIndex = _filterValues.indexOf(currentFilter);
    final tasksAsync = ref.watch(filteredTasksProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.s5,
                AppDimensions.s4,
                AppDimensions.s5,
                AppDimensions.s3,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tareas',
                      style: AppTypography.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/add-task'),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.blueSoft,
                        borderRadius: BorderRadius.circular(AppDimensions.rSm),
                      ),
                      child: const Icon(Icons.add_rounded, color: AppColors.blue),
                    ),
                  ),
                ],
              ),
            ),

            // Filter chips
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
                itemCount: _filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: AppDimensions.s2),
                itemBuilder: (_, i) {
                  final active = filterIndex == i;
                  return GestureDetector(
                    onTap: () => ref.read(taskFilterProvider.notifier).state = _filterValues[i],
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.s4,
                        vertical: AppDimensions.s2,
                      ),
                      decoration: BoxDecoration(
                        color: active ? AppColors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppDimensions.rPill),
                        border: Border.all(
                          color: active ? AppColors.blue : AppColors.borderStrong,
                        ),
                      ),
                      child: Text(
                        _filters[i],
                        style: AppTypography.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : AppColors.textDim,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppDimensions.s3),

            // Task list
            Expanded(
              child: tasksAsync.when(
                loading: () => const DFLoading(),
                error: (e, _) => DFError(
                  message: e.toString(),
                  onRetry: () => ref.invalidate(tasksProvider),
                ),
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return DFEmpty(
                      icon: Icons.check_box_outline_blank_rounded,
                      title: 'No tienes tareas',
                      subtitle: 'Agrega tu primera tarea para empezar',
                      actionLabel: 'Agregar tarea',
                      onAction: () => context.push('/add-task'),
                    );
                  }

                  final todayStr = DFDateUtils.isoDate(DateTime.now());
                  final tomorrowStr = DFDateUtils.isoDate(DateTime.now().add(const Duration(days: 1)));

                  final todayTasks = tasks.where((t) => t.date == todayStr).toList();
                  final tomorrowTasks = tasks.where((t) => t.date == tomorrowStr).toList();
                  final otherTasks = tasks.where((t) => t.date != todayStr && t.date != tomorrowStr).toList();

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.s5,
                      0,
                      AppDimensions.s5,
                      AppDimensions.s6,
                    ),
                    children: [
                      if (todayTasks.isNotEmpty) _TaskGroup(title: 'Hoy', tasks: todayTasks),
                      if (tomorrowTasks.isNotEmpty) ...[
                        if (todayTasks.isNotEmpty) const SizedBox(height: AppDimensions.s5),
                        _TaskGroup(title: 'Mañana', tasks: tomorrowTasks),
                      ],
                      if (otherTasks.isNotEmpty) ...[
                        if (todayTasks.isNotEmpty || tomorrowTasks.isNotEmpty)
                          const SizedBox(height: AppDimensions.s5),
                        _TaskGroup(title: 'Más adelante', tasks: otherTasks),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskGroup extends StatelessWidget {
  const _TaskGroup({required this.title, required this.tasks});
  final String title;
  final List<TaskEntity> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTypography.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textDim,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: AppDimensions.s3),
        ...tasks.map((t) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.s2 + 2),
              child: _TaskCard(task: t),
            )),
      ],
    );
  }
}

class _TaskCard extends ConsumerWidget {
  const _TaskCard({required this.task});
  final TaskEntity task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.push('/task-detail', extra: task),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.s4 - 2),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (task.id != null) {
                  if (!task.completed) {
                    ref.read(celebrationTriggerProvider.notifier).state = true;
                  }
                  ref.read(tasksProvider.notifier).toggle(task.id!, !task.completed);
                }
              },
              child: _CircleCheck(done: task.completed, color: task.category.color),
            ),
            const SizedBox(width: AppDimensions.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: AppTypography.inter(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                      color: task.completed ? AppColors.textDim : AppColors.text,
                    ).copyWith(
                      decoration: task.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded, size: 12, color: AppColors.textMute),
                      const SizedBox(width: 4),
                      Text(
                        DFDateUtils.formatTime(task.time),
                        style: AppTypography.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMute,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
Container(
               width: 10,
               height: 10,
               decoration: BoxDecoration(
                 color: task.category.color,
                 shape: BoxShape.circle,
               ),
             ),
           ],
         ),
       ),
     );
   }
}

class _CircleCheck extends StatelessWidget {
  const _CircleCheck({required this.done, required this.color});
  final bool done;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: done ? 'Tarea completada' : 'Marcar tarea como completada',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: done ? color : Colors.transparent,
          border: Border.all(
            color: done ? color : AppColors.borderStrong,
            width: 1.8,
          ),
        ),
        child: done
            ? const Icon(Icons.check_rounded, size: 13, color: Colors.white)
            : null,
      ),
    );
  }
}
