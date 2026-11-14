import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../database/database_helper.dart';
import '../models/period_entry.dart';
import 'database_provider.dart';

const _uuid = Uuid();

class PeriodEntryNotifier extends AsyncNotifier<List<PeriodEntry>> {
  @override
  Future<List<PeriodEntry>> build() async {
    final db = ref.watch(databaseHelperProvider);
    await db.init();
    return db.periodEntryDao.getAll();
  }

  Future<bool> add(PeriodEntry entry) async {
    final db = ref.read(databaseHelperProvider);
    final hasOverlap =
        await db.periodEntryDao.hasOverlap(entry.startDate, entry.endDate, null);
    if (hasOverlap) return false;
    await db.periodEntryDao.insert(entry);
    ref.invalidateSelf();
    return true;
  }

  Future<void> remove(String id) async {
    final db = ref.read(databaseHelperProvider);
    await db.periodEntryDao.delete(id);
    ref.invalidateSelf();
  }

  PeriodEntry createNew({
    required DateTime startDate,
    DateTime? endDate,
    String flowLevel = '未记录',
    String painLevel = '未记录',
    String? note,
  }) {
    final now = DateTime.now();
    return PeriodEntry(
      id: _uuid.v4(),
      startDate: startDate,
      endDate: endDate,
      flowLevel: flowLevel,
      painLevel: painLevel,
      note: note,
      createdAt: now,
      updatedAt: now,
    );
  }
}

final periodEntriesProvider =
    AsyncNotifierProvider<PeriodEntryNotifier, List<PeriodEntry>>(
        PeriodEntryNotifier.new);
