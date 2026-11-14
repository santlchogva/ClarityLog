import 'package:sqflite/sqflite.dart';
import '../../models/food_entry.dart';

class FoodEntryDao {
  final Database db;
  FoodEntryDao(this.db);

  static const table = 'food_entries';

  Future<void> insert(FoodEntry entry) async {
    await db.insert(table, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(FoodEntry entry) async {
    await db.update(table, entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<void> delete(String id) async {
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FoodEntry>> getAll() async {
    final rows = await db.query(table, orderBy: 'logged_at DESC');
    return rows.map(FoodEntry.fromMap).toList();
  }

  Future<List<FoodEntry>> getForDay(DateTime date) async {
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
    return rows.map(FoodEntry.fromMap).toList();
  }
}
