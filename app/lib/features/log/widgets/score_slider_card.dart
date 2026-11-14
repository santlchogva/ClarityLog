import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_dimensions.dart';

class ScoreSliderCard extends StatelessWidget {
  final int score;
  final ValueChanged<int> onChanged;

  const ScoreSliderCard({
    super.key,
    required this.score,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.cardPaddingH),
      decoration: BoxDecoration(
        color: AppColors.sage,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('清晰度自评', style: AppTextStyles.subtitle),
              Text(
                '$score',
                style: AppTextStyles.scoreNum.copyWith(
                  fontSize: 24,
                  color: AppColors.pine,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.pine,
              inactiveTrackColor: AppColors.sageMed,
              thumbColor: AppColors.pine,
              overlayColor: AppColors.pine.withOpacity(0.12),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 12),
            ),
            child: Slider(
              value: score.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('极不清晰', style: AppTextStyles.note),
              Text('非常清晰', style: AppTextStyles.note),
            ],
          ),
        ],
      ),
    );
  }
}
