import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/df_date_utils.dart';
import '../../domain/entities/task.dart';
import '../../presentation/providers/tasks_provider.dart';
import '../../shared/widgets/df_app_bar.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key, required this.task});
  final TaskEntity task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(tasksProvider.notifier);

    // Category styling
    final catColor = switch (task.category) {
      TaskCategory.academic => AppColors.catAcademic,
      TaskCategory.health => AppColors.catHealth,
      TaskCategory.personal => AppColors.catPersonal,
    };

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: DFAppBar(
        title: 'Detalle',
        showBack: true,
        showMore: true,
        onMore: () => _showOptions(context, ref, notifier),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.s5,
          AppDimensions.s2,
          AppDimensions.s5,
          AppDimensions.s6,
        ),
        children: [
          // Hero card
          Container(
            padding: const EdgeInsets.all(AppDimensions.s5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [catColor, catColor.withAlpha(204)],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.rXl),
              boxShadow: [
                BoxShadow(
                  color: catColor.withAlpha(64),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.s2 + 2, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(56),
                    borderRadius: BorderRadius.circular(AppDimensions.rPill),
                  ),
                  child: Text(
                    task.category.label,
                    style: AppTypography.inter(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.s4 - 2),
                Text(
                  task.title,
                  style: AppTypography.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.15,
                    color: Colors.white,
                  ),
                ),
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: AppDimensions.s1 + 2),
                  Text(
                    task.description,
                    style: AppTypography.inter(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.s4 + 2),

          // Meta rows
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
            ),
            child: Column(
              children: [
                _MetaRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Fecha',
                  value: DFDateUtils.displayDate(task.date),
                  isLast: false,
                ),
                _MetaRow(
                  icon: Icons.access_time_rounded,
                  label: 'Hora',
                  value: DFDateUtils.formatTime(task.time),
                  isLast: false,
                ),
                _MetaRow(
                  icon: Icons.notifications_outlined,
                  label: 'Recordatorio',
                  value: '${task.reminderMinutes} minutos antes',
                  isLast: false,
                ),
                _MetaRow(
                  icon: Icons.flag_outlined,
                  label: 'Estado',
                  value: task.completed ? 'Completada ✓' : 'Pendiente',
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.s5),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/add-task', extra: task),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.s4 - 2),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit_outlined,
                            size: 16, color: AppColors.text),
                        const SizedBox(width: AppDimensions.s2),
                        Text(
                          'Editar',
                          style: AppTypography.inter(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.s2 + 2),
              Expanded(
                child: GestureDetector(
                  onTap: task.completed
                      ? null
                      : () async {
                          await notifier.toggle(task.id!, true);
                          if (context.mounted) context.pop();
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.s4 - 2),
                    decoration: BoxDecoration(
                      color: task.completed
                          ? AppColors.surfaceHi
                          : AppColors.success,
                      borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
                      boxShadow: task.completed
                          ? null
                          : [
                              BoxShadow(
                                color: AppColors.success.withAlpha(64),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          task.completed
                              ? Icons.check_circle_rounded
                              : Icons.check_rounded,
                          size: 16,
                          color: task.completed ? AppColors.textDim : AppColors.bg,
                        ),
                        const SizedBox(width: AppDimensions.s2),
                        Text(
                          task.completed ? 'Completada' : 'Completar',
                          style: AppTypography.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: task.completed ? AppColors.textDim : AppColors.bg,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context, WidgetRef ref, dynamic notifier) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: AppColors.text),
              title: Text('Editar',
                  style: AppTypography.inter(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                context.push('/add-task', extra: task);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded,
                  color: AppColors.danger),
              title: Text('Eliminar',
                  style: AppTypography.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.danger,
                  )),
              onTap: () async {
                Navigator.pop(context);
                await notifier.delete(task.id!);
                if (context.mounted) context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isLast,
  });
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.s4,
        vertical: AppDimensions.s4 - 2,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(AppDimensions.rSm),
            ),
            child: Icon(icon, size: 18, color: AppColors.textDim),
          ),
          const SizedBox(width: AppDimensions.s4 - 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: AppTypography.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMute,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  style: AppTypography.inter(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
