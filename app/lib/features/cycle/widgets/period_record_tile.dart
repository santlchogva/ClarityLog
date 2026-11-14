import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/period_entry.dart';
import '../../../shared/utils/date_format_util.dart';

class PeriodRecordTile extends StatelessWidget {
  final PeriodEntry entry;
  final VoidCallback onDelete;

  const PeriodRecordTile({
    super.key,
    required this.entry,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final endLabel = entry.endDate != null
        ? formatShortDate(entry.endDate!)
        : '持续中';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.periodBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${formatShortDate(entry.startDate)} — $endLabel',
                  style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.period,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '出血量：${entry.flowLevel} · 疼痛：${entry.painLevel}',
                  style: AppTextStyles.note,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onDelete,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.muted,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('删除', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
