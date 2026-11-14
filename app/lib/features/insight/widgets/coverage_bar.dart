import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class CoverageBar extends StatelessWidget {
  final int loggedDays;
  final int totalDays;

  const CoverageBar({
    super.key,
    required this.loggedDays,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = totalDays == 0 ? 0.0 : loggedDays / totalDays;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('记录覆盖', style: AppTextStyles.note),
            Text('$loggedDays / $totalDays 天',
                style: AppTextStyles.note
                    .copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            backgroundColor: AppColors.sage,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.pine),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
