import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/df_date_utils.dart';
import '../../domain/entities/task.dart';
import '../../l10n/app_localizations.dart';
import '../../presentation/providers/tasks_provider.dart';
import '../../shared/widgets/df_app_bar.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key, this.task});
  final TaskEntity? task;

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  TaskCategory _cat = TaskCategory.academic;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  int _reminderIdx = 1; // 0=5min, 1=15min, 2=30min, 3=60min

  static const _reminderMins = [5, 15, 30, 60];

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    final t = widget.task;
    if (t != null) {
      _titleCtrl.text = t.title;
      _descCtrl.text = t.description;
      _cat = t.category;
      try {
        _date = DFDateUtils.parseIso(t.date);
      } catch (_) {}
      try {
        final parts = t.time.split(':');
        _time = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      } catch (_) {}
      _reminderIdx = _reminderMins.indexOf(t.reminderMinutes).clamp(0, 3);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: AppColors.blue),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: AppColors.blue),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.taskTitleRequired)),
      );
      return;
    }

    final task = TaskEntity(
      id: widget.task?.id,
      title: title,
      description: _descCtrl.text.trim(),
      category: _cat,
      date: DFDateUtils.isoDate(_date),
      time: DFDateUtils.timeToString(_time.hour, _time.minute),
      reminderMinutes: _reminderMins[_reminderIdx],
    );

    final notifier = ref.read(tasksProvider.notifier);
    if (_isEditing) {
      await notifier.edit(task);
    } else {
      await notifier.add(task);
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reminderLabels = [
      l10n.reminder5min,
      l10n.reminder15min,
      l10n.reminder30min,
      l10n.reminder60min,
    ];
    final cats = [
      _CatOpt(Icons.person_outline_rounded, l10n.labelPersonal, AppColors.catPersonal, TaskCategory.personal),
      _CatOpt(Icons.menu_book_outlined, l10n.labelAcademic, AppColors.catAcademic, TaskCategory.academic),
      _CatOpt(Icons.health_and_safety_outlined, l10n.labelHealth, AppColors.catHealth, TaskCategory.health),
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: DFAppBar(
        title: _isEditing ? l10n.editTaskTitle : l10n.addTaskTitle,
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.s5,
          AppDimensions.s2,
          AppDimensions.s5,
          AppDimensions.s6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            _Field(
              label: l10n.taskTitleLabel,
              child: _inputBox(
                child: TextField(
                  controller: _titleCtrl,
                  style: AppTypography.inter(fontSize: 15, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: l10n.taskTitleHint,
                  ),
                  cursorColor: AppColors.blue,
                ),
              ),
            ),

            // Description
            _Field(
              label: l10n.taskDescLabel,
              child: _inputBox(
                minHeight: 80,
                child: TextField(
                  controller: _descCtrl,
                  maxLines: null,
                  style: AppTypography.inter(fontSize: 14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: l10n.taskDescHint,
                  ),
                  cursorColor: AppColors.blue,
                ),
              ),
            ),

            // Category
            _Field(
              label: l10n.taskCategoryLabel,
              child: Row(
                children: cats.asMap().entries.map((e) {
                  final c = e.value;
                  final active = _cat == c.category;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _cat = c.category),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: e.key < cats.length - 1 ? AppDimensions.s2 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.s4 - 2),
                        decoration: BoxDecoration(
                          color: active ? c.color.withAlpha(34) : AppColors.surface,
                          border: Border.all(
                            color: active ? c.color : AppColors.border,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(AppDimensions.rMd),
                        ),
                        child: Column(
                          children: [
                            Icon(c.icon,
                                size: 20,
                                color: active ? c.color : AppColors.textDim),
                            const SizedBox(height: AppDimensions.s1 + 2),
                            Text(
                              c.label,
                              style: AppTypography.inter(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: active ? c.color : AppColors.textDim,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Date + Time
            Row(
              children: [
                Expanded(
                  child: _Field(
                    label: l10n.taskDateLabel,
                    child: GestureDetector(
                      onTap: _pickDate,
                      child: _inputBox(
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined,
                                size: 18, color: AppColors.textDim),
                            const SizedBox(width: AppDimensions.s2 + 2),
                            Text(
                              DFDateUtils.shortDate(DFDateUtils.isoDate(_date)),
                              style: AppTypography.inter(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.s3),
                Expanded(
                  child: _Field(
                    label: l10n.taskTimeLabel,
                    child: GestureDetector(
                      onTap: _pickTime,
                      child: _inputBox(
                        child: Row(
                          children: [
                            const Icon(Icons.access_time_rounded,
                                size: 18, color: AppColors.textDim),
                            const SizedBox(width: AppDimensions.s2 + 2),
                            Text(
                              _time.format(context),
                              style: AppTypography.inter(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Reminder
            _Field(
              label: l10n.taskReminderLabel,
              child: Wrap(
                spacing: AppDimensions.s2,
                runSpacing: AppDimensions.s2,
                children: List.generate(reminderLabels.length, (i) {
                  final active = _reminderIdx == i;
                  return GestureDetector(
                    onTap: () => setState(() => _reminderIdx = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.s4 - 2,
                        vertical: AppDimensions.s2,
                      ),
                      decoration: BoxDecoration(
                        color: active ? AppColors.blue : AppColors.surface,
                        border: Border.all(
                          color: active ? AppColors.blue : AppColors.border,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(AppDimensions.rPill),
                      ),
                      child: Text(
                        l10n.reminderBefore(reminderLabels[i]),
                        style: AppTypography.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : AppColors.textDim,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: AppDimensions.s6),

            GestureDetector(
              onTap: _save,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(AppDimensions.rMd),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blue.withAlpha(64),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  _isEditing ? l10n.saveTaskEdit : l10n.saveTaskCreate,
                  style: AppTypography.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputBox({required Widget child, double minHeight = 48}) =>
      Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.s4 - 2,
          vertical: AppDimensions.s3,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
        ),
        child: child,
      );
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textDim,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: AppDimensions.s2),
          child,
        ],
      ),
    );
  }
}

class _CatOpt {
  const _CatOpt(this.icon, this.label, this.color, this.category);
  final IconData icon;
  final String label;
  final Color color;
  final TaskCategory category;
}