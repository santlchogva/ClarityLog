import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/card_base.dart';

class PemQuestionCard extends StatelessWidget {
  final bool? answer; // null=未回答, true=是, false=否
  final ValueChanged<bool?> onChanged;

  const PemQuestionCard({
    super.key,
    required this.answer,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      variant: CardVariant.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('活动后当天或随后两天，是否明显加重？',
              style: AppTextStyles.subtitle),
          const SizedBox(height: 10),
          Row(
            children: [
              _chip('是', answer == true,
                  () => onChanged(answer == true ? null : true)),
              const SizedBox(width: 8),
              _chip('否', answer == false,
                  () => onChanged(answer == false ? null : false)),
              const SizedBox(width: 8),
              _chip('不确定', answer == null,
                  () => onChanged(null)),
            ],
          ),
          if (answer == true) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.amberLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE8C8A8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '活动后不适可能延迟 12–48 小时出现（CDC 长新冠临床指导）。建议与医生讨论个体化活动方案，暂不增加运动量。',
                    style: AppTextStyles.note,
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => context.push('/evidence/pem_activity'),
                    child: Text(
                      '查看依据 →',
                      style: AppTextStyles.note.copyWith(
                          color: AppColors.amber,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.amber : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? AppColors.amber : AppColors.border,
              width: 1.5),
        ),
        child: Text(
          label,
          style: AppTextStyles.chipLabel.copyWith(
              color: selected ? Colors.white : AppColors.inkMed),
        ),
      ),
    );
  }
}
