import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/primary_button.dart';

class OnboardingStep1 extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingStep1({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 72),
          Text('你好', style: AppTextStyles.display),
          const SizedBox(height: 8),
          Text('清志是你的脑雾记录本', style: AppTextStyles.h1),
          const SizedBox(height: 24),
          Text(
            '每天花 1 分钟记录感受、饮食和活动，帮你发现个人规律，与医生更有效地沟通。',
            style: AppTextStyles.bodyLg,
          ),
          const Spacer(),
          _FeatureRow(
            icon: Icons.bar_chart_outlined,
            title: '追踪清晰度',
            sub: '0-10 分自评，每天一次',
          ),
          const SizedBox(height: 20),
          _FeatureRow(
            icon: Icons.restaurant_outlined,
            title: '饮食记录',
            sub: '记录饮食与感受的关联',
          ),
          const SizedBox(height: 20),
          _FeatureRow(
            icon: Icons.directions_walk_outlined,
            title: '活动追踪',
            sub: '安全考量 PEM 风险',
          ),
          const SizedBox(height: 20),
          _FeatureRow(
            icon: Icons.lightbulb_outline,
            title: '科学建议',
            sub: '每条建议附引用依据',
          ),
          const Spacer(),
          PrimaryButton(
            label: '开始',
            onTap: onNext,
            fullWidth: true,
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String sub;

  const _FeatureRow({required this.icon, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.sage,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: AppColors.pine),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.subtitle),
            Text(sub, style: AppTextStyles.note),
          ],
        ),
      ],
    );
  }
}
