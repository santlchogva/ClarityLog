import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../database/database_helper.dart';
import '../models/food_entry.dart';
import '../../shared/utils/date_format_util.dart';
import 'database_provider.dart';

const _uuid = Uuid();

class FoodEntryNotifier extends AsyncNotifier<List<FoodEntry>> {
  @override
  Future<List<FoodEntry>> build() async {
    final db = ref.watch(databaseHelperProvider);
    await db.init();
    return db.foodEntryDao.getAll();
  }

  Future<void> add(FoodEntry entry) async {
    final db = ref.read(databaseHelperProvider);
    await db.foodEntryDao.insert(entry);
    ref.invalidateSelf();
  }

  Future<void> remove(String id) async {
    final db = ref.read(databaseHelperProvider);
    await db.foodEntryDao.delete(id);
    ref.invalidateSelf();
  }

  FoodEntry createNew({
    required String mealType,
    required String description,
    String? postMealFeel,
    String? note,
  }) {
    final now = DateTime.now();
    return FoodEntry(
      id: _uuid.v4(),
      loggedAt: now,
      mealType: mealType,
      description: description,
      postMealFeel: postMealFeel,
      note: note,
      createdAt: now,
      updatedAt: now,
    );
  }
}

final foodEntriesProvider =
    AsyncNotifierProvider<FoodEntryNotifier, List<FoodEntry>>(
        FoodEntryNotifier.new);

final todayFoodEntriesProvider =
    Provider<AsyncValue<List<FoodEntry>>>((ref) {
  return ref.watch(foodEntriesProvider).whenData((entries) {
    final today = DateTime.now();
    return entries
        .where((e) => isSameDay(e.loggedAt, today))
        .toList();
  });
});
