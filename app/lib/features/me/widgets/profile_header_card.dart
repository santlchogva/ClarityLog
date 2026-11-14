import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/user_profile.dart';

class ProfileHeaderCard extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onEdit;

  const ProfileHeaderCard({
    super.key,
    required this.profile,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final ageLabel = profile.ageRange.isNotEmpty ? profile.ageRange : '未设置';
    final sexLabel = profile.sex.isNotEmpty ? profile.sex : '未设置';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.pine,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.pineMedium,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline,
                color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$sexLabel · $ageLabel',
                    style: AppTextStyles.h2.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  profile.ageContextNote(),
                  style: AppTextStyles.note.copyWith(
                      color: Colors.white.withOpacity(0.75)),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onEdit,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white.withOpacity(0.85),
              padding: EdgeInsets.zero,
            ),
            child: const Text('编辑', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
