import 'package:sqflite/sqflite.dart';
import '../../models/period_entry.dart';

class PeriodEntryDao {
  final Database db;
  PeriodEntryDao(this.db);

  static const table = 'period_entries';

  Future<void> insert(PeriodEntry entry) async {
    await db.insert(table, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(PeriodEntry entry) async {
    await db.update(table, entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<void> delete(String id) async {
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PeriodEntry>> getAll() async {
    final rows = await db.query(table, orderBy: 'start_date DESC');
    return rows.map(PeriodEntry.fromMap).toList();
  }

  /// Checks if [startDate, endDate] overlaps with any existing entry
  /// except the one with [excludeId].
  Future<bool> hasOverlap(
      DateTime startDate, DateTime? endDate, String? excludeId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final endMs = endDate?.millisecondsSinceEpoch ?? now;
    final startMs = startDate.millisecondsSinceEpoch;

    final rows = await db.rawQuery(
      '''SELECT id FROM $table
         WHERE (start_date <= ? AND (end_date IS NULL OR end_date >= ?))
           AND id != ?''',
      [endMs, startMs, excludeId ?? ''],
    );
    return rows.isNotEmpty;
  }
}
