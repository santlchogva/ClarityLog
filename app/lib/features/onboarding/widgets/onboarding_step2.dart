import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/user_profile.dart';
import '../../../shared/widgets/primary_button.dart';

class OnboardingStep2 extends StatefulWidget {
  final UserProfile initial;
  final ValueChanged<UserProfile> onComplete;

  const OnboardingStep2({
    super.key,
    required this.initial,
    required this.onComplete,
  });

  @override
  State<OnboardingStep2> createState() => _OnboardingStep2State();
}

class _OnboardingStep2State extends State<OnboardingStep2> {
  String? _sex;
  String? _ageRange;
  bool _cycleTracking = false;
  String? _error;

  static const _sexOptions = ['女', '男', '非二元/其他', '不愿透露'];
  static const _ageOptions = ['18-25岁', '26-35岁', '36-45岁', '46-55岁', '56岁以上'];

  @override
  void initState() {
    super.initState();
    _sex = widget.initial.sex.isNotEmpty ? widget.initial.sex : null;
    _ageRange = widget.initial.ageRange.isNotEmpty ? widget.initial.ageRange : null;
    _cycleTracking = widget.initial.cycleTrackingEnabled;
  }

  void _handleComplete() {
    if (_ageRange == null) {
      setState(() => _error = '请选择年龄段');
      return;
    }
    setState(() => _error = null);
    final profile = widget.initial.copyWith(
      sex: _sex ?? '不愿透露',
      ageRange: _ageRange!,
      cycleTrackingEnabled: _cycleTracking,
      onboardingCompleted: true,
    );
    widget.onComplete(profile);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 56),
          Text('简单了解一下', style: AppTextStyles.h1),
          const SizedBox(height: 8),
          Text('这些信息仅存储在你的设备上，可随时更改。',
              style: AppTextStyles.note),
          const SizedBox(height: 32),
          Text('性别（可选）', style: AppTextStyles.subtitle),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _sexOptions.map((s) {
              final selected = _sex == s;
              return ChoiceChip(
                label: Text(s, style: AppTextStyles.chipLabel),
                selected: selected,
                onSelected: (_) => setState(() => _sex = selected ? null : s),
                selectedColor: AppColors.pine,
                backgroundColor: AppColors.sage,
                labelStyle: AppTextStyles.chipLabel.copyWith(
                    color: selected ? Colors.white : AppColors.inkMed),
                side: BorderSide.none,
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          Text('年龄段', style: AppTextStyles.subtitle),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _ageOptions.map((a) {
              final selected = _ageRange == a;
              return ChoiceChip(
                label: Text(a, style: AppTextStyles.chipLabel),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    _ageRange = selected ? null : a;
                    _error = null;
                  });
                },
                selectedColor: AppColors.pine,
                backgroundColor: AppColors.sage,
                labelStyle: AppTextStyles.chipLabel.copyWith(
                    color: selected ? Colors.white : AppColors.inkMed),
                side: BorderSide.none,
                showCheckmark: false,
              );
            }).toList(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: AppTextStyles.note.copyWith(color: AppColors.amber)),
          ],
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('开启月经周期追踪', style: AppTextStyles.subtitle),
                    Text('可在之后设置里随时开关', style: AppTextStyles.note),
                  ],
                ),
              ),
              Switch(
                value: _cycleTracking,
                onChanged: (v) => setState(() => _cycleTracking = v),
                activeColor: AppColors.pine,
              ),
            ],
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            label: '完成设置',
            onTap: _handleComplete,
            fullWidth: true,
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
