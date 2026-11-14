import 'package:sqflite/sqflite.dart';
import '../../models/log_entry.dart';

class LogEntryDao {
  final Database db;
  LogEntryDao(this.db);

  static const table = 'log_entries';

  Future<void> insert(LogEntry entry) async {
    await db.insert(table, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(LogEntry entry) async {
    await db.update(table, entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<void> delete(String id) async {
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<LogEntry>> getAll() async {
    final rows = await db.query(table, orderBy: 'logged_at DESC');
    return rows.map(LogEntry.fromMap).toList();
  }

  Future<List<LogEntry>> getRange(DateTime from, DateTime to) async {
    final rows = await db.query(
      table,
      where: 'logged_at >= ? AND logged_at <= ?',
      whereArgs: [
        from.millisecondsSinceEpoch,
        to.millisecondsSinceEpoch,
      ],
      orderBy: 'logged_at DESC',
    );
    return rows.map(LogEntry.fromMap).toList();
  }

  Future<LogEntry?> getForDay(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final rows = await db.query(
      table,
      where: 'logged_at >= ? AND logged_at < ?',
      whereArgs: [
        start.millisecondsSinceEpoch,
        end.millisecondsSinceEpoch,
      ],
      orderBy: 'logged_at DESC',
      limit: 1,
    );
    return rows.isEmpty ? null : LogEntry.fromMap(rows.first);
  }
}
