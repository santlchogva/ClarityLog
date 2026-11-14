import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/utils/symptoms_constants.dart';

class SymptomChipSelector extends StatelessWidget {
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  const SymptomChipSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  void _toggle(String symptom) {
    List<String> next;
    if (symptom == kFallbackSymptom) {
      next = selected.contains(symptom) ? [] : [kFallbackSymptom];
    } else {
      final withoutFallback =
          selected.where((s) => s != kFallbackSymptom).toList();
      if (withoutFallback.contains(symptom)) {
        next = withoutFallback.where((s) => s != symptom).toList();
      } else {
        next = [...withoutFallback, symptom];
      }
    }
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ..._buildGroup(kPrimarySymptoms),
        ..._buildGroup(kSecondarySymptoms),
        _buildChip(kFallbackSymptom),
      ],
    );
  }

  List<Widget> _buildGroup(List<String> symptoms) =>
      symptoms.map(_buildChip).toList();

  Widget _buildChip(String symptom) {
    final isSelected = selected.contains(symptom);
    return FilterChip(
      label: Text(symptom, style: AppTextStyles.chipLabel),
      selected: isSelected,
      onSelected: (_) => _toggle(symptom),
      selectedColor: AppColors.pine,
      backgroundColor: AppColors.white,
      labelStyle: AppTextStyles.chipLabel.copyWith(
        color: isSelected ? Colors.white : AppColors.inkMed,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.pine : AppColors.border,
        width: 1.5,
      ),
      shape: const StadiumBorder(),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    );
  }
}
