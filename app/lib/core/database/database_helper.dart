import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'daos/log_entry_dao.dart';
import 'daos/food_entry_dao.dart';
import 'daos/activity_entry_dao.dart';
import 'daos/period_entry_dao.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _db;

  late LogEntryDao logEntryDao;
  late FoodEntryDao foodEntryDao;
  late ActivityEntryDao activityEntryDao;
  late PeriodEntryDao periodEntryDao;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'clarity_log.db');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    logEntryDao = LogEntryDao(db);
    foodEntryDao = FoodEntryDao(db);
    activityEntryDao = ActivityEntryDao(db);
    periodEntryDao = PeriodEntryDao(db);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE log_entries (
        id           TEXT    PRIMARY KEY,
        logged_at    INTEGER NOT NULL,
        score        INTEGER NOT NULL,
        symptoms     TEXT    NOT NULL DEFAULT '[]',
        sleep_hours  REAL,
        stress_level INTEGER,
        note         TEXT,
        is_low_energy_mode INTEGER NOT NULL DEFAULT 0,
        created_at   INTEGER NOT NULL,
        updated_at   INTEGER NOT NULL
      )
    ''');
    await db.execute(
        'CREATE INDEX idx_log_logged_at ON log_entries(logged_at DESC)');

    await db.execute('''
      CREATE TABLE food_entries (
        id              TEXT    PRIMARY KEY,
        logged_at       INTEGER NOT NULL,
        meal_type       TEXT    NOT NULL,
        description     TEXT    NOT NULL,
        photo_path      TEXT,
        post_meal_feel  TEXT,
        note            TEXT,
        created_at      INTEGER NOT NULL,
        updated_at      INTEGER NOT NULL
      )
    ''');
    await db.execute(
        'CREATE INDEX idx_food_logged_at ON food_entries(logged_at DESC)');

    await db.execute('''
      CREATE TABLE activity_entries (
        id                      TEXT    PRIMARY KEY,
        logged_at               INTEGER NOT NULL,
        activity_type           TEXT    NOT NULL,
        duration_minutes        INTEGER NOT NULL,
        intensity_level         INTEGER NOT NULL,
        post_exertion_malaise   INTEGER,
        note                    TEXT,
        created_at              INTEGER NOT NULL,
        updated_at              INTEGER NOT NULL
      )
    ''');
    await db.execute(
        'CREATE INDEX idx_activity_logged_at ON activity_entries(logged_at DESC)');

    await db.execute('''
      CREATE TABLE period_entries (
        id           TEXT    PRIMARY KEY,
        start_date   INTEGER NOT NULL,
        end_date     INTEGER,
        flow_level   TEXT    NOT NULL DEFAULT '未记录',
        pain_level   TEXT    NOT NULL DEFAULT '未记录',
        note         TEXT,
        created_at   INTEGER NOT NULL,
        updated_at   INTEGER NOT NULL
      )
    ''');
    await db.execute(
        'CREATE INDEX idx_period_start_date ON period_entries(start_date DESC)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future migrations go here
  }

  Future<void> init() async {
    await database;
  }
}
