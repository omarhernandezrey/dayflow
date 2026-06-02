import 'package:flutter_test/flutter_test.dart';
import 'package:dayflow/domain/entities/habit.dart';

void main() {
  group('HabitEntity', () {
    test('should create with defaults', () {
      final habit = HabitEntity(id: 1, title: 'Beber agua');
      expect(habit.title, 'Beber agua');
      expect(habit.icon, 'water');
      expect(habit.colorHex, '#3D7BFF');
      expect(habit.frequency, HabitFrequency.daily);
      expect(habit.activeDays, '1111100');
      expect(habit.goal, 1.0);
      expect(habit.unit, 'count');
    });

    test('should check active days correctly', () {
      final habit = HabitEntity(title: 'Test', activeDays: '1010100');
      expect(habit.isActiveOnDay(1), true);
      expect(habit.isActiveOnDay(2), false);
      expect(habit.isActiveOnDay(3), true);
      expect(habit.isActiveOnDay(4), false);
      expect(habit.isActiveOnDay(5), true);
      expect(habit.isActiveOnDay(6), false);
      expect(habit.isActiveOnDay(7), false);
    });

    test('should return false for out of range weekday', () {
      final habit = HabitEntity(title: 'Test', activeDays: '1111111');
      expect(habit.isActiveOnDay(0), false);
      expect(habit.isActiveOnDay(8), false);
    });

    test('should support equality by value', () {
      final habit1 = HabitEntity(id: 1, title: 'Test');
      final habit2 = HabitEntity(id: 1, title: 'Test');
      expect(habit1, equals(habit2));
    });

    test('should support copyWith', () {
      final habit = HabitEntity(id: 1, title: 'Test', goal: 5.0);
      final updated = habit.copyWith(goal: 10.0);
      expect(updated.goal, 10.0);
      expect(updated.title, 'Test');
    });
  });

  group('HabitFrequency', () {
    test('should convert from string correctly', () {
      expect(HabitFrequency.fromString('daily'), HabitFrequency.daily);
      expect(HabitFrequency.fromString('weekly'), HabitFrequency.weekly);
      expect(HabitFrequency.fromString('custom'), HabitFrequency.custom);
      expect(HabitFrequency.fromString('unknown'), HabitFrequency.daily);
    });

    test('should convert to value string correctly', () {
      expect(HabitFrequency.daily.value, 'daily');
      expect(HabitFrequency.weekly.value, 'weekly');
      expect(HabitFrequency.custom.value, 'custom');
    });
  });
}