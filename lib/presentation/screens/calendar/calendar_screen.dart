import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.s5,
            AppDimensions.s4,
            AppDimensions.s5,
            AppDimensions.s6,
          ),
          children: [
            Text(
              'Calendario',
              style: AppTypography.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: AppDimensions.s5),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.rLg),
                border: Border.all(color: AppColors.border),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _format,
                startingDayOfWeek: StartingDayOfWeek.monday,
                locale: 'es',
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: true,
                  formatButtonDecoration: BoxDecoration(
                    color: AppColors.blueSoft,
                    borderRadius: BorderRadius.circular(AppDimensions.rPill),
                  ),
                  formatButtonTextStyle: AppTypography.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue,
                  ),
                  titleTextStyle: AppTypography.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.textDim),
                  rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.textDim),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  defaultTextStyle: AppTypography.inter(fontSize: 14, color: AppColors.text),
                  weekendTextStyle: AppTypography.inter(fontSize: 14, color: AppColors.textDim),
                  todayDecoration: BoxDecoration(
                    color: AppColors.blueSoft,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: AppTypography.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blue,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: AppTypography.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  cellMargin: const EdgeInsets.all(4),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: AppTypography.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDim,
                  ),
                  weekendStyle: AppTypography.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMute,
                  ),
                ),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                onFormatChanged: (format) => setState(() => _format = format),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
