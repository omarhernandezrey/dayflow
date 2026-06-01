import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' hide DatabaseException;

import '../../core/errors/exceptions.dart';
import 'local_database.dart';

class LocalDatabaseImpl implements LocalDatabase {
  static const String _dbName = 'dayflow_v3.db';
  static const int _dbVersion = 1;

  Database? _db;

  Future<Database> get _database async => _db ??= await _init();

  Future<Database> _init() async {
    try {
      final dir = await getDatabasesPath();
      final path = join(dir, _dbName);

      return openDatabase(
        path,
        version: _dbVersion,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e, st) {
      throw DatabaseException('Failed to initialize database: $e', stackTrace: st);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createV2Schema(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _migrateV1ToV2(db);
    }
    if (oldVersion < 3) {
      await _migrateV2ToV3(db);
    }
  }

  Future<void> _createV2Schema(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tasks (
        id               INTEGER PRIMARY KEY AUTOINCREMENT,
        title            TEXT    NOT NULL,
        description      TEXT    NOT NULL DEFAULT '',
        category         TEXT    NOT NULL DEFAULT 'personal',
        date             TEXT    NOT NULL,
        time             TEXT    NOT NULL,
        reminder_minutes INTEGER NOT NULL DEFAULT 15,
        completed        INTEGER NOT NULL DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS habits (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        title       TEXT    NOT NULL,
        icon        TEXT    NOT NULL DEFAULT 'water',
        color_hex   TEXT    NOT NULL DEFAULT '#3D7BFF',
        frequency   TEXT    NOT NULL DEFAULT 'daily',
        active_days TEXT    NOT NULL DEFAULT '1111100',
        goal        REAL    NOT NULL DEFAULT 1.0,
        unit        TEXT    NOT NULL DEFAULT 'count'
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS habit_progress (
        id            INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_id      INTEGER NOT NULL,
        date          TEXT    NOT NULL,
        current_value REAL    NOT NULL DEFAULT 0,
        target_value  REAL    NOT NULL DEFAULT 1,
        unit          TEXT    NOT NULL DEFAULT 'count',
        FOREIGN KEY (habit_id) REFERENCES habits(id) ON DELETE CASCADE,
        UNIQUE(habit_id, date)
      )
    ''');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_habit_progress_habit_date ON habit_progress(habit_id, date)');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS achievements (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        key         TEXT    NOT NULL UNIQUE,
        title       TEXT    NOT NULL,
        description TEXT    NOT NULL,
        icon        TEXT    NOT NULL,
        unlocked_at TEXT,
        progress    INTEGER NOT NULL DEFAULT 0,
        target      INTEGER NOT NULL DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS settings (
        key   TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id            INTEGER PRIMARY KEY AUTOINCREMENT,
        name          TEXT    NOT NULL,
        email         TEXT    NOT NULL UNIQUE,
        password_hash TEXT    NOT NULL,
        created_at    TEXT
      )
    ''');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_tasks_date ON tasks(date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_tasks_category ON tasks(category)');

    await _seedAchievements(db);
  }

  Future<void> _migrateV1ToV2(Database db) async {
    // Migrate tasks (no schema change)
    // Migrate habits: add unit column, change goal to REAL
    final habitsExist = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='habits'",
    );
    if (habitsExist.isNotEmpty) {
      // SQLite doesn't support ALTER COLUMN, so we recreate
      await db.execute('ALTER TABLE habits RENAME TO habits_old');
      await db.execute('''
        CREATE TABLE habits (
          id          INTEGER PRIMARY KEY AUTOINCREMENT,
          title       TEXT    NOT NULL,
          icon        TEXT    NOT NULL DEFAULT 'water',
          color_hex   TEXT    NOT NULL DEFAULT '#3D7BFF',
          frequency   TEXT    NOT NULL DEFAULT 'daily',
          active_days TEXT    NOT NULL DEFAULT '1111100',
          goal        REAL    NOT NULL DEFAULT 1.0,
          unit        TEXT    NOT NULL DEFAULT 'count'
        )
      ''');
      await db.execute('''
        INSERT INTO habits (id, title, icon, color_hex, frequency, active_days, goal, unit)
        SELECT id, title, icon, color_hex, frequency, active_days,
               CAST(goal AS REAL), 'count'
        FROM habits_old
      ''');
      await db.execute('DROP TABLE habits_old');
    }

    // Migrate habit_progress: new schema with current_value/target_value/unit
    final progressExist = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='habit_progress'",
    );
    if (progressExist.isNotEmpty) {
      await db.execute('ALTER TABLE habit_progress RENAME TO habit_progress_old');
      await db.execute('''
        CREATE TABLE habit_progress (
          id            INTEGER PRIMARY KEY AUTOINCREMENT,
          habit_id      INTEGER NOT NULL,
          date          TEXT    NOT NULL,
          current_value REAL    NOT NULL DEFAULT 0,
          target_value  REAL    NOT NULL DEFAULT 1,
          unit          TEXT    NOT NULL DEFAULT 'count',
          FOREIGN KEY (habit_id) REFERENCES habits(id) ON DELETE CASCADE,
          UNIQUE(habit_id, date)
        )
      ''');
      await db.execute('''
        INSERT INTO habit_progress (habit_id, date, current_value, target_value, unit)
        SELECT habit_id, date,
               CASE WHEN completed = 1 THEN 1.0 ELSE 0.0 END,
               1.0,
               'count'
        FROM habit_progress_old
      ''');
      await db.execute('DROP TABLE habit_progress_old');
    }

    // Create new tables if they don't exist
    final achievementsExist = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='achievements'",
    );
    if (achievementsExist.isEmpty) {
      await db.execute('''
        CREATE TABLE achievements (
          id          INTEGER PRIMARY KEY AUTOINCREMENT,
          key         TEXT    NOT NULL UNIQUE,
          title       TEXT    NOT NULL,
          description TEXT    NOT NULL,
          icon        TEXT    NOT NULL,
          unlocked_at TEXT,
          progress    INTEGER NOT NULL DEFAULT 0,
          target      INTEGER NOT NULL DEFAULT 1
        )
      ''');
      await _seedAchievements(db);
    }

    final settingsExist = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='settings'",
    );
    if (settingsExist.isEmpty) {
      await db.execute('''
        CREATE TABLE settings (
          key   TEXT PRIMARY KEY,
          value TEXT NOT NULL
        )
      ''');
    }
  }

  Future<void> _migrateV2ToV3(Database db) async {
    final usersExist = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='users'",
    );
    if (usersExist.isEmpty) {
      await db.execute('''
        CREATE TABLE users (
          id          INTEGER PRIMARY KEY AUTOINCREMENT,
          name        TEXT    NOT NULL,
          email       TEXT    NOT NULL UNIQUE,
          password_hash TEXT  NOT NULL,
          created_at  TEXT
        )
      ''');
      await db.execute('CREATE INDEX idx_users_email ON users(email)');
    }
  }

  Future<void> _seedAchievements(Database db) async {
    final batch = db.batch();
    final seeds = _achievementSeeds();
    for (final a in seeds) {
      batch.insert('achievements', a, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit(noResult: true);
  }

  List<Map<String, dynamic>> _achievementSeeds() => [
    {'key': 'first_task', 'title': 'Primer paso', 'description': 'Completa tu primera tarea', 'icon': 'check', 'target': 1},
    {'key': 'streak_7', 'title': 'En racha', 'description': '7 días seguidos completando al menos un hábito', 'icon': 'fire', 'target': 7},
    {'key': 'streak_30', 'title': 'Imparable', 'description': '30 días seguidos completando al menos un hábito', 'icon': 'fire', 'target': 30},
    {'key': 'tasks_100', 'title': 'Productivo', 'description': 'Completa 100 tareas', 'icon': 'task', 'target': 100},
    {'key': 'habits_5', 'title': 'Multitasker', 'description': 'Crea 5 hábitos activos', 'icon': 'habit', 'target': 5},
    {'key': 'perfect_week', 'title': 'Semana perfecta', 'description': '100% de cumplimiento en una semana', 'icon': 'star', 'target': 1},
    {'key': 'early_bird', 'title': 'Madrugador', 'description': 'Completa 10 tareas antes de las 9 AM', 'icon': 'sun', 'target': 10},
    {'key': 'hydrated', 'title': 'Hidratado', 'description': 'Completa tu meta de agua 7 días seguidos', 'icon': 'water', 'target': 7},
    {'key': 'planner', 'title': 'Planificador', 'description': 'Crea 50 tareas', 'icon': 'calendar', 'target': 50},
    {'key': 'consistent', 'title': 'Consistente', 'description': 'Completa todas tus tareas del día 5 veces', 'icon': 'trophy', 'target': 5},
    {'key': 'habit_master', 'title': 'Maestro de hábitos', 'description': 'Alcanza la meta de un hábito con goal > 1, 10 veces', 'icon': 'crown', 'target': 10},
    {'key': 'data_export', 'title': 'Respaldado', 'description': 'Exporta tus datos por primera vez', 'icon': 'backup', 'target': 1},
  ];

  // ─── Tasks ────────────────────────────────────────────────────

  @override
  Future<int> insertTask(Map<String, dynamic> map) async {
    try {
      final db = await _database;
      return await db.insert('tasks', map);
    } catch (e, st) {
      throw DatabaseException('Failed to insert task: $e', stackTrace: st);
    }
  }

  @override
  Future<int> updateTask(Map<String, dynamic> map, int id) async {
    try {
      final db = await _database;
      return await db.update('tasks', map, where: 'id = ?', whereArgs: [id]);
    } catch (e, st) {
      throw DatabaseException('Failed to update task: $e', stackTrace: st);
    }
  }

  @override
  Future<int> deleteTask(int id) async {
    try {
      final db = await _database;
      return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e, st) {
      throw DatabaseException('Failed to delete task: $e', stackTrace: st);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryTasks({String? where, List<dynamic>? whereArgs}) async {
    try {
      final db = await _database;
      return await db.query(
        'tasks',
        where: where,
        whereArgs: whereArgs,
        orderBy: 'date ASC, time ASC',
      );
    } catch (e, st) {
      throw DatabaseException('Failed to query tasks: $e', stackTrace: st);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> searchTasks(String query) async {
    try {
      final db = await _database;
      final pattern = '%$query%';
      return await db.query(
        'tasks',
        where: 'title LIKE ? OR description LIKE ?',
        whereArgs: [pattern, pattern],
        orderBy: 'date ASC, time ASC',
      );
    } catch (e, st) {
      throw DatabaseException('Failed to search tasks: $e', stackTrace: st);
    }
  }

  // ─── Habits ───────────────────────────────────────────────────

  @override
  Future<int> insertHabit(Map<String, dynamic> map) async {
    try {
      final db = await _database;
      return await db.insert('habits', map);
    } catch (e, st) {
      throw DatabaseException('Failed to insert habit: $e', stackTrace: st);
    }
  }

  @override
  Future<int> updateHabit(Map<String, dynamic> map, int id) async {
    try {
      final db = await _database;
      return await db.update('habits', map, where: 'id = ?', whereArgs: [id]);
    } catch (e, st) {
      throw DatabaseException('Failed to update habit: $e', stackTrace: st);
    }
  }

  @override
  Future<int> deleteHabit(int id) async {
    try {
      final db = await _database;
      return await db.delete('habits', where: 'id = ?', whereArgs: [id]);
    } catch (e, st) {
      throw DatabaseException('Failed to delete habit: $e', stackTrace: st);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryHabits() async {
    try {
      final db = await _database;
      return await db.query('habits', orderBy: 'id ASC');
    } catch (e, st) {
      throw DatabaseException('Failed to query habits: $e', stackTrace: st);
    }
  }

  // ─── Habit Progress ───────────────────────────────────────────

  @override
  Future<void> insertOrReplaceHabitProgress(Map<String, dynamic> map) async {
    try {
      final db = await _database;
      await db.insert(
        'habit_progress',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, st) {
      throw DatabaseException('Failed to insert habit progress: $e', stackTrace: st);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryHabitProgress({String? where, List<dynamic>? whereArgs}) async {
    try {
      final db = await _database;
      return await db.query(
        'habit_progress',
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e, st) {
      throw DatabaseException('Failed to query habit progress: $e', stackTrace: st);
    }
  }

  // ─── Achievements ─────────────────────────────────────────────

  @override
  Future<List<Map<String, dynamic>>> queryAchievements() async {
    try {
      final db = await _database;
      return await db.query('achievements', orderBy: 'id ASC');
    } catch (e, st) {
      throw DatabaseException('Failed to query achievements: $e', stackTrace: st);
    }
  }

  @override
  Future<void> insertOrReplaceAchievement(Map<String, dynamic> map) async {
    try {
      final db = await _database;
      await db.insert(
        'achievements',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, st) {
      throw DatabaseException('Failed to insert achievement: $e', stackTrace: st);
    }
  }

  // ─── Raw queries / settings ───────────────────────────────────

  @override
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? args]) async {
    try {
      final db = await _database;
      return await db.rawQuery(sql, args);
    } catch (e, st) {
      throw DatabaseException('Failed raw query: $e', stackTrace: st);
    }
  }

  // ─── Users ────────────────────────────────────────────────────

  @override
  Future<int> insertUser(Map<String, dynamic> map) async {
    try {
      final db = await _database;
      return await db.insert('users', map);
    } catch (e, st) {
      throw DatabaseException('Failed to insert user: $e', stackTrace: st);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryUsers({String? where, List<dynamic>? whereArgs, String? orderBy, int? limit}) async {
    try {
      final db = await _database;
      return await db.query('users', where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit);
    } catch (e, st) {
      throw DatabaseException('Failed to query users: $e', stackTrace: st);
    }
  }

  @override
  Future<void> close() async {
    try {
      if (_db != null) {
        await _db!.close();
        _db = null;
      }
    } catch (e, st) {
      throw DatabaseException('Failed to close database: $e', stackTrace: st);
    }
  }
}
