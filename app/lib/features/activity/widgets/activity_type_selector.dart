import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/utils/symptoms_constants.dart';

class ActivityTypeSelector extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const ActivityTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: kActivityTypes.map((t) {
        final sel = t == selected;
        return FilterChip(
          label: Text(t,
              style: AppTextStyles.chipLabel.copyWith(
                  color: sel ? Colors.white : AppColors.inkMed)),
          selected: sel,
          onSelected: (_) => onChanged(t),
          selectedColor: AppColors.pine,
          backgroundColor: AppColors.white,
          side: BorderSide(
              color: sel ? AppColors.pine : AppColors.border,
              width: 1.5),
          shape: const StadiumBorder(),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}
