import '../../core/errors/exceptions.dart';

/// Abstract contract for local database operations.
/// All methods throw [AppException] on failure.
abstract class LocalDatabase {
  Future<int> insertTask(Map<String, dynamic> map);
  Future<int> updateTask(Map<String, dynamic> map, int id);
  Future<int> deleteTask(int id);
  Future<List<Map<String, dynamic>>> queryTasks({String? where, List<dynamic>? whereArgs});
  Future<List<Map<String, dynamic>>> searchTasks(String query);

  Future<int> insertHabit(Map<String, dynamic> map);
  Future<int> updateHabit(Map<String, dynamic> map, int id);
  Future<int> deleteHabit(int id);
  Future<List<Map<String, dynamic>>> queryHabits();

  Future<void> insertOrReplaceHabitProgress(Map<String, dynamic> map);
  Future<List<Map<String, dynamic>>> queryHabitProgress({String? where, List<dynamic>? whereArgs});

  Future<List<Map<String, dynamic>>> queryAchievements();
  Future<void> insertOrReplaceAchievement(Map<String, dynamic> map);

  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? args]);

  // ─── Users ────────────────────────────────────────────────────
  Future<int> insertUser(Map<String, dynamic> map);
  Future<List<Map<String, dynamic>>> queryUsers({String? where, List<dynamic>? whereArgs, String? orderBy, int? limit});

  Future<void> close();
}
