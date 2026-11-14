import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/food_entry.dart';
import '../../../shared/widgets/card_base.dart';

class FoodEntryCard extends StatelessWidget {
  final FoodEntry entry;
  final VoidCallback? onDelete;

  const FoodEntryCard({super.key, required this.entry, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return CardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.sage,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(entry.mealType,
                    style: AppTextStyles.note.copyWith(
                        color: AppColors.muted,
                        fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              if (onDelete != null)
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(Icons.close,
                      size: 16, color: AppColors.muted),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(entry.description, style: AppTextStyles.body),
          if (entry.postMealFeel != null) ...[
            const SizedBox(height: 6),
            Text('餐后感受：${entry.postMealFeel}',
                style: AppTextStyles.note),
          ],
        ],
      ),
    );
  }
}
