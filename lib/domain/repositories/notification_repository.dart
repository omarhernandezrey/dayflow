import '../../domain/entities/task.dart';

abstract class NotificationRepository {
  Future<void> init();
  Future<bool> requestPermissions();
  Future<void> scheduleTaskReminder(TaskEntity task);
  Future<void> cancelReminder(int taskId);
  Future<void> cancelAll();
}