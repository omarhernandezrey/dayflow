import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/entities/habit.dart';
import '../../presentation/providers/habits_provider.dart';
import '../../shared/widgets/df_app_bar.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key, this.habit});
  final HabitEntity? habit;

  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _titleCtrl = TextEditingController();

  String _icon = 'water';
  HabitFrequency _freq = HabitFrequency.daily;
  List<bool> _activeDays = [true, true, true, true, true, false, false];
  double _goal = 1.0;
  String _unit = 'count';

  static const _iconOpts = [
    _IconOpt('water', Icons.water_drop_outlined, '#38BDF8'),
    _IconOpt('dumbbell', Icons.fitness_center_rounded, '#22C55E'),
    _IconOpt('leaf', Icons.eco_outlined, '#A78BFA'),
    _IconOpt('moon', Icons.nights_stay_outlined, '#6366F1'),
    _IconOpt('book', Icons.menu_book_outlined, '#F59E0B'),
    _IconOpt('sparkle', Icons.auto_awesome_outlined, '#F472B6'),
  ];

  static const _dayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  bool get _isEditing => widget.habit != null;

  @override
  void initState() {
    super.initState();
    final h = widget.habit;
    if (h != null) {
      _titleCtrl.text = h.title;
      _icon = h.icon;
      _freq = h.frequency;
      _activeDays = List.generate(
          7, (i) => i < h.activeDays.length && h.activeDays[i] == '1');
      _goal = h.goal;
      _unit = h.unit;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  String get _activeDaysStr =>
      _activeDays.map((b) => b ? '1' : '0').join();

  _IconOpt get _activeIconOpt =>
      _iconOpts.firstWhere((o) => o.id == _icon, orElse: () => _iconOpts.first);

  Color get _activeColor => _hexColor(_activeIconOpt.colorHex);

  Future<void> _save() async {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre es obligatorio')),
      );
      return;
    }

    final habit = HabitEntity(
      id: widget.habit?.id,
      title: title,
      icon: _icon,
      colorHex: _activeIconOpt.colorHex,
      frequency: _freq,
      activeDays: _activeDaysStr,
      goal: _goal,
      unit: _unit,
    );

    final notifier = ref.read(habitsProvider.notifier);
    if (_isEditing) {
      await notifier.edit(habit);
    } else {
      await notifier.add(habit);
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: DFAppBar(
        title: _isEditing ? 'Editar hábito' : 'Nuevo hábito',
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
            // Icon preview
            Center(
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: _activeColor.withAlpha(34),
                  borderRadius: BorderRadius.circular(AppDimensions.rXl),
                  border: Border.all(color: _activeColor.withAlpha(68)),
                ),
                child: Icon(_activeIconOpt.iconData, size: 40, color: _activeColor),
              ),
            ),

            // Name
            _FieldLabel('Nombre del hábito'),
            Container(
              padding: const EdgeInsets.all(AppDimensions.s4 - 2),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
              ),
              child: TextField(
                controller: _titleCtrl,
                style: AppTypography.inter(fontSize: 15, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Nombre del hábito…',
                ),
                cursorColor: AppColors.blue,
              ),
            ),

            // Icon selector
            _FieldLabel('Icono'),
            Wrap(
              spacing: AppDimensions.s2 + 2,
              runSpacing: AppDimensions.s2 + 2,
              children: _iconOpts.map((o) {
                final active = _icon == o.id;
                final color = _hexColor(o.colorHex);
                return GestureDetector(
                  onTap: () => setState(() => _icon = o.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: active ? color.withAlpha(51) : AppColors.surface,
                      border: Border.all(
                        color: active ? color : AppColors.border,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
                    ),
                    child: Icon(o.iconData,
                        size: 22,
                        color: active ? color : AppColors.textDim),
                  ),
                );
              }).toList(),
            ),

            // Frequency
            _FieldLabel('Frecuencia'),
            Row(
              children: HabitFrequency.values.asMap().entries.map((e) {
                final f = e.value;
                final active = _freq == f;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _freq = f),
                    child: Container(
                      margin: EdgeInsets.only(
                        right: e.key < HabitFrequency.values.length - 1
                            ? AppDimensions.s2
                            : 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.s2 + 2),
                      decoration: BoxDecoration(
                        color: active ? AppColors.blue : AppColors.surface,
                        border: Border.all(
                          color: active ? AppColors.blue : AppColors.border,
                        ),
                        borderRadius: BorderRadius.circular(AppDimensions.rSm),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        f.label,
                        style: AppTypography.inter(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : AppColors.textDim,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: AppDimensions.s2 + 2),

            // Day selector
            Row(
              children: List.generate(7, (i) {
                final active = _activeDays[i];
                return Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _activeDays[i] = !_activeDays[i]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: EdgeInsets.only(
                          right: i < 6 ? AppDimensions.s1 + 2 : 0),
                      height: 38,
                      decoration: BoxDecoration(
                        color: active ? AppColors.blueSoft : AppColors.surface,
                        border: Border.all(
                          color: active
                              ? AppColors.blue.withAlpha(85)
                              : AppColors.border,
                        ),
                        borderRadius: BorderRadius.circular(AppDimensions.rSm),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _dayLabels[i],
                        style: AppTypography.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: active ? AppColors.blue : AppColors.textMute,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            // Goal
            _FieldLabel('Meta diaria'),
            Row(
              children: [
                _QtyBtn(
                  icon: Icons.remove_rounded,
                  onTap: () =>
                      setState(() => _goal = (_goal - 1.0).clamp(1.0, 99.0)),
                ),
                const SizedBox(width: AppDimensions.s2 + 2),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.s4 - 2),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${_goal.toStringAsFixed(_goal == _goal.toInt() ? 0 : 1)} ${_goal == 1.0 ? 'vez' : 'veces'}',
                      style: AppTypography.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.s2 + 2),
                _QtyBtn(
                  icon: Icons.add_rounded,
                  onTap: () =>
                      setState(() => _goal = (_goal + 1.0).clamp(1.0, 99.0)),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.s6),
            GestureDetector(
              onTap: _save,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _activeColor,
                  borderRadius: BorderRadius.circular(AppDimensions.rMd),
                  boxShadow: [
                    BoxShadow(
                      color: _activeColor.withAlpha(64),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  _isEditing ? 'Guardar cambios' : 'Crear hábito',
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
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.s4,
        bottom: AppDimensions.s2,
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTypography.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.textDim,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
        ),
        child: Icon(icon, size: 22, color: AppColors.text),
      ),
    );
  }
}

Color _hexColor(String hex) {
  try {
    return Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16));
  } catch (_) {
    return AppColors.blue;
  }
}

class _IconOpt {
  const _IconOpt(this.id, this.iconData, this.colorHex);
  final String id;
  final IconData iconData;
  final String colorHex;
}
