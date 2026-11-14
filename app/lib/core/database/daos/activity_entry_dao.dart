import 'package:sqflite/sqflite.dart';
import '../../models/activity_entry.dart';

class ActivityEntryDao {
  final Database db;
  ActivityEntryDao(this.db);

  static const table = 'activity_entries';

  Future<void> insert(ActivityEntry entry) async {
    await db.insert(table, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(ActivityEntry entry) async {
    await db.update(table, entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<void> delete(String id) async {
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ActivityEntry>> getAll() async {
    final rows = await db.query(table, orderBy: 'logged_at DESC');
    return rows.map(ActivityEntry.fromMap).toList();
  }

  Future<List<ActivityEntry>> getForDay(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final rows = await db.query(
      table,
      where: 'logged_at >= ? AND logged_at < ?',
      whereArgs: [
        start.millisecondsSinceEpoch,
        end.millisecondsSinceEpoch,
      ],
      orderBy: 'logged_at ASC',
    );
    return rows.map(ActivityEntry.fromMap).toList();
  }

  /// Returns true if any recent activity entry has PEM flagged,
  /// used to gate exercise-increase suggestions.
  Future<bool> hasRecentPem() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 3));
    final rows = await db.query(
      table,
      where: 'logged_at >= ? AND post_exertion_malaise = 1',
      whereArgs: [cutoff.millisecondsSinceEpoch],
      limit: 1,
    );
    return rows.isNotEmpty;
  }
}
