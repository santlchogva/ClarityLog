import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/data/evidence_data.dart';
import '../../../shared/widgets/card_base.dart';

class SuggestionCard extends StatelessWidget {
  final Evidence evidence;
  final bool pemBlocked;
  final VoidCallback onTap;

  const SuggestionCard({
    super.key,
    required this.evidence,
    required this.onTap,
    this.pemBlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('今天了解一件小事',
              style: AppTextStyles.label.copyWith(letterSpacing: 1.5)),
          const SizedBox(height: 8),
          Text(evidence.title, style: AppTextStyles.subtitle),
          const SizedBox(height: 4),
          Text(evidence.summary,
              style: AppTextStyles.bodySm,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('查看建议与依据',
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.pine,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward,
                  size: 14, color: AppColors.pine),
            ],
          ),
        ],
      ),
    );
  }
}
