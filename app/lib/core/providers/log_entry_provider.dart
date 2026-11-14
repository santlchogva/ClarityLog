import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/log_entry.dart';
import '../../shared/utils/date_format_util.dart';
import 'database_provider.dart';

const _uuid = Uuid();

class LogEntryNotifier extends AsyncNotifier<List<LogEntry>> {
  @override
  Future<List<LogEntry>> build() async {
    final db = ref.watch(databaseHelperProvider);
    await db.init();
    return db.logEntryDao.getAll();
  }

  Future<void> add(LogEntry entry) async {
    final db = ref.read(databaseHelperProvider);
    await db.logEntryDao.insert(entry);
    ref.invalidateSelf();
  }

  Future<void> updateEntry(LogEntry entry) async {
    final db = ref.read(databaseHelperProvider);
    await db.logEntryDao.update(entry);
    ref.invalidateSelf();
  }

  Future<void> remove(String id) async {
    final db = ref.read(databaseHelperProvider);
    await db.logEntryDao.delete(id);
    ref.invalidateSelf();
  }

  LogEntry createNew({
    required int score,
    required List<String> symptoms,
    double? sleepHours,
    int? stressLevel,
    String? note,
    bool isLowEnergyMode = false,
  }) {
    final now = DateTime.now();
    return LogEntry(
      id: _uuid.v4(),
      loggedAt: now,
      score: score,
      symptoms: symptoms,
      sleepHours: sleepHours,
      stressLevel: stressLevel,
      note: note,
      isLowEnergyMode: isLowEnergyMode,
      createdAt: now,
      updatedAt: now,
    );
  }
}

final logEntriesProvider =
    AsyncNotifierProvider<LogEntryNotifier, List<LogEntry>>(
        LogEntryNotifier.new);

/// Today's log entry (null if none recorded yet today).
final todayLogEntryProvider = Provider<AsyncValue<LogEntry?>>((ref) {
  return ref.watch(logEntriesProvider).whenData((entries) {
    final today = DateTime.now();
    for (final e in entries) {
      if (isSameDay(e.loggedAt, today)) return e;
    }
    return null;
  });
});

/// Last 7 calendar days' entries (index 0 = 6 days ago, index 6 = today).
/// Null means no entry for that day.
final weeklyScoresProvider =
    Provider<AsyncValue<List<LogEntry?>>>((ref) {
  return ref.watch(logEntriesProvider).whenData((entries) {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final day = now.subtract(Duration(days: 6 - i));
      for (final e in entries) {
        if (isSameDay(e.loggedAt, day)) return e;
      }
      return null;
    });
  });
});
