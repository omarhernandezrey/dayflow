import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../core/constants/app_constants.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  @override
  Future<void> init() async {
    if (_ready) return;
    tz_data.initializeTimeZones();

    final local = DateTime.now().timeZoneName;
    try {
      tz.setLocalLocation(tz.getLocation(local));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(settings);
    _ready = true;
  }

  @override
  Future<bool> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      final granted = await android?.requestNotificationsPermission();
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final granted = await ios?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    return true;
  }

  @override
  Future<void> scheduleTaskReminder(TaskEntity task) async {
    if (!_ready || task.id == null) return;
    final scheduled = task.scheduledDateTime;
    if (scheduled == null) return;

    final reminderAt = scheduled.subtract(Duration(minutes: task.reminderMinutes));
    if (reminderAt.isBefore(DateTime.now())) return;

    final tzTime = tz.TZDateTime.from(reminderAt, tz.local);

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        AppConstants.notifChannelId,
        AppConstants.notifChannelName,
        channelDescription: AppConstants.notifChannelDesc,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      task.id!,
      'DayFlow — ${task.title}',
      'Comienza en ${task.reminderMinutes} min',
      tzTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Future<void> cancelReminder(int taskId) async {
    if (!_ready) return;
    await _plugin.cancel(taskId);
  }

  @override
  Future<void> cancelAll() async {
    if (!_ready) return;
    await _plugin.cancelAll();
  }
}