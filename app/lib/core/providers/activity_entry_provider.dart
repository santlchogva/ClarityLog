import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/activity_entry.dart';
import 'database_provider.dart';

const _uuid = Uuid();

class ActivityEntryNotifier extends AsyncNotifier<List<ActivityEntry>> {
  @override
  Future<List<ActivityEntry>> build() async {
    final db = ref.watch(databaseHelperProvider);
    await db.init();
    return db.activityEntryDao.getAll();
  }

  Future<void> add(ActivityEntry entry) async {
    final db = ref.read(databaseHelperProvider);
    await db.activityEntryDao.insert(entry);
    ref.invalidateSelf();
  }

  Future<void> remove(String id) async {
    final db = ref.read(databaseHelperProvider);
    await db.activityEntryDao.delete(id);
    ref.invalidateSelf();
  }

  ActivityEntry createNew({
    required String activityType,
    required int durationMinutes,
    required int intensityLevel,
    bool? postExertionMalaise,
    String? note,
  }) {
    final now = DateTime.now();
    return ActivityEntry(
      id: _uuid.v4(),
      loggedAt: now,
      activityType: activityType,
      durationMinutes: durationMinutes,
      intensityLevel: intensityLevel,
      postExertionMalaise: postExertionMalaise,
      note: note,
      createdAt: now,
      updatedAt: now,
    );
  }
}

final activityEntriesProvider =
    AsyncNotifierProvider<ActivityEntryNotifier, List<ActivityEntry>>(
        ActivityEntryNotifier.new);

/// True if any ActivityEntry in the last 3 days has PEM flagged.
final hasPemProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(activityEntriesProvider).whenData((entries) {
    final cutoff = DateTime.now().subtract(const Duration(days: 3));
    return entries.any(
        (e) => e.postExertionMalaise == true && e.loggedAt.isAfter(cutoff));
  });
});
