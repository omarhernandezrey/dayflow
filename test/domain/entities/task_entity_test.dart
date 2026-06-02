import 'package:flutter_test/flutter_test.dart';
import 'package:dayflow/domain/entities/task.dart';

void main() {
  group('TaskEntity', () {
    test('should create with defaults', () {
      final task = TaskEntity(
        title: 'Estudiar',
        category: TaskCategory.personal,
        date: '2024-06-15',
        time: '14:30',
      );
      expect(task.title, 'Estudiar');
      expect(task.category, TaskCategory.personal);
      expect(task.completed, false);
      expect(task.reminderMinutes, 15);
      expect(task.description, '');
    });

    test('should support equality by value', () {
      final task1 = TaskEntity(
        id: 1,
        title: 'Test',
        category: TaskCategory.health,
        date: '2024-01-01',
        time: '10:00',
      );
      final task2 = TaskEntity(
        id: 1,
        title: 'Test',
        category: TaskCategory.health,
        date: '2024-01-01',
        time: '10:00',
      );
      expect(task1, equals(task2));
    });

    test('should parse scheduledDateTime correctly', () {
      final task = TaskEntity(
        title: 'Test',
        category: TaskCategory.academic,
        date: '2024-06-15',
        time: '14:30',
      );
      final dt = task.scheduledDateTime!;
      expect(dt.year, 2024);
      expect(dt.month, 6);
      expect(dt.day, 15);
      expect(dt.hour, 14);
      expect(dt.minute, 30);
    });

    test('should return null for invalid scheduledDateTime', () {
      final task = TaskEntity(
        title: 'Test',
        category: TaskCategory.personal,
        date: 'invalid',
        time: '00:00',
      );
      expect(task.scheduledDateTime, isNull);
    });

    test('should support copyWith', () {
      final task = TaskEntity(
        id: 1,
        title: 'Test',
        category: TaskCategory.personal,
        date: '2024-01-01',
        time: '10:00',
      );
      final completed = task.copyWith(completed: true);
      expect(completed.completed, true);
      expect(completed.title, 'Test');
    });
  });

  group('TaskCategory', () {
    test('should convert from string correctly', () {
      expect(TaskCategory.fromString('personal'), TaskCategory.personal);
      expect(TaskCategory.fromString('academic'), TaskCategory.academic);
      expect(TaskCategory.fromString('health'), TaskCategory.health);
      expect(TaskCategory.fromString('unknown'), TaskCategory.personal);
    });

    test('should convert to value string correctly', () {
      expect(TaskCategory.personal.value, 'personal');
      expect(TaskCategory.academic.value, 'academic');
      expect(TaskCategory.health.value, 'health');
    });
  });
}