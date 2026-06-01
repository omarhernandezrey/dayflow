import 'package:home_widget/home_widget.dart';

/// Service for updating the Android/iOS home screen widget.
/// Requires native platform configuration (see README).
class HomeWidgetService {
  static const String _appGroupId = 'group.com.dayflow.widget';
  static const String _widgetName = 'DayFlowWidget';

  static Future<void> init() async {
    await HomeWidget.setAppGroupId(_appGroupId);
  }

  static Future<void> update({
    required int pendingTasks,
    required int completedHabits,
    required int totalHabits,
    required String nextTaskTitle,
    required String nextTaskTime,
  }) async {
    await HomeWidget.saveWidgetData('pending_tasks', pendingTasks);
    await HomeWidget.saveWidgetData('completed_habits', completedHabits);
    await HomeWidget.saveWidgetData('total_habits', totalHabits);
    await HomeWidget.saveWidgetData('next_task_title', nextTaskTitle);
    await HomeWidget.saveWidgetData('next_task_time', nextTaskTime);
    await HomeWidget.updateWidget(
      name: _widgetName,
      androidName: 'DayFlowWidgetProvider',
      iOSName: 'DayFlowWidget',
    );
  }

  static Future<void> clear() async {
    await HomeWidget.saveWidgetData('pending_tasks', 0);
    await HomeWidget.saveWidgetData('completed_habits', 0);
    await HomeWidget.saveWidgetData('total_habits', 0);
    await HomeWidget.saveWidgetData('next_task_title', '');
    await HomeWidget.saveWidgetData('next_task_time', '');
    await HomeWidget.updateWidget(
      name: _widgetName,
      androidName: 'DayFlowWidgetProvider',
      iOSName: 'DayFlowWidget',
    );
  }
}
