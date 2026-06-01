abstract final class AppConstants {
  // Notification channel
  static const String notifChannelId = 'dayflow_tasks';
  static const String notifChannelName = 'Recordatorios de tareas';
  static const String notifChannelDesc =
      'Notificaciones de recordatorio para actividades programadas';

  // Shared preferences keys
  static const String prefUserName = 'user_name';
  static const String prefStreak = 'global_streak';

  // Category values (sync with TaskCategory.value)
  static const String catPersonal = 'personal';
  static const String catAcademic = 'academic';
  static const String catHealth = 'health';

  // Demo user
  static const String defaultUserName = 'Usuario';
}
