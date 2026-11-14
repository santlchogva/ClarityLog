import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/providers/food_entry_provider.dart';
import '../../shared/widgets/label_text.dart';
import '../../shared/widgets/primary_button.dart';
import '../food/widgets/food_entry_card.dart';
import '../food/widgets/add_food_form.dart';

class FoodScreen extends ConsumerStatefulWidget {
  const FoodScreen({super.key});

  @override
  ConsumerState<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends ConsumerState<FoodScreen> {
  bool _showForm = false;

  @override
  Widget build(BuildContext context) {
    final todayFoodAsync = ref.watch(todayFoodEntriesProvider);
    final entries = todayFoodAsync.valueOrNull ?? [];

    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
        title: Text('今日饮食', style: AppTextStyles.h2),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 8),
          if (entries.isEmpty && !_showForm)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text('还没有饮食记录', style: AppTextStyles.note),
              ),
            ),
          ...entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FoodEntryCard(
                  entry: e,
                  onDelete: () => ref
                      .read(foodEntriesProvider.notifier)
                      .remove(e.id),
                ),
              )),
          if (_showForm) ...[
            const SizedBox(height: 8),
            AddFoodForm(
              onSave: (entry) async {
                await ref.read(foodEntriesProvider.notifier).add(entry);
                setState(() => _showForm = false);
              },
              onCancel: () => setState(() => _showForm = false),
            ),
          ],
          const SizedBox(height: 16),
          if (!_showForm)
            PrimaryButton(
              label: '添加饮食记录',
              onPressed: () => setState(() => _showForm = true),
              mode: ButtonMode.outlined,
            ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
