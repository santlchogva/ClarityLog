import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/utils/symptoms_constants.dart';

class AddFoodForm extends StatefulWidget {
  final void Function(
    String mealType,
    String description,
    String? postMealFeel,
  ) onSave;
  final VoidCallback onCancel;

  const AddFoodForm({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<AddFoodForm> createState() => _AddFoodFormState();
}

class _AddFoodFormState extends State<AddFoodForm> {
  String _mealType = kMealTypes.first;
  final _descController = TextEditingController();
  String? _postMealFeel;
  String? _error;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    if (_descController.text.trim().isEmpty) {
      setState(() => _error = '请填写食物描述');
      return;
    }
    widget.onSave(
      _mealType,
      _descController.text.trim(),
      _postMealFeel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('添加饮食记录', style: AppTextStyles.subtitle),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: kMealTypes.map((t) {
              final sel = t == _mealType;
              return FilterChip(
                label: Text(t,
                    style: AppTextStyles.chipLabel.copyWith(
                        color: sel ? Colors.white : AppColors.inkMed)),
                selected: sel,
                onSelected: (_) => setState(() => _mealType = t),
                selectedColor: AppColors.pine,
                backgroundColor: AppColors.white,
                side: BorderSide(
                    color: sel ? AppColors.pine : AppColors.border,
                    width: 1.5),
                shape: const StadiumBorder(),
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descController,
            maxLines: 2,
            style: AppTextStyles.body,
            decoration: InputDecoration(
              hintText: '例如：米饭 / 豆腐 / 青菜 / 鸡蛋',
              hintStyle:
                  AppTextStyles.note.copyWith(color: AppColors.muted),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.pine),
              ),
              contentPadding: const EdgeInsets.all(12),
              errorText: _error,
            ),
            onChanged: (_) => setState(() => _error = null),
          ),
          const SizedBox(height: 10),
          Text('餐后感受（可选）', style: AppTextStyles.note),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: kPostMealFeelings.map((f) {
              final sel = f == _postMealFeel;
              return FilterChip(
                label: Text(f,
                    style: AppTextStyles.chipLabel.copyWith(
                        color: sel ? Colors.white : AppColors.inkMed)),
                selected: sel,
                onSelected: (_) =>
                    setState(() => _postMealFeel = sel ? null : f),
                selectedColor: AppColors.pine,
                backgroundColor: AppColors.white,
                side: BorderSide(
                    color: sel ? AppColors.pine : AppColors.border,
                    width: 1.5),
                shape: const StadiumBorder(),
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pine,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  elevation: 0,
                ),
                child: const Text('保存'),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: widget.onCancel,
              child: Text('取消',
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.muted)),
            ),
          ]),
        ],
      ),
    );
  }
}
