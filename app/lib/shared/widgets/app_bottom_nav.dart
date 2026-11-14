import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(Icons.access_time_rounded, '今日'),
    _NavItem(Icons.add_circle_outline_rounded, '记录'),
    _NavItem(Icons.show_chart_rounded, '洞察'),
    _NavItem(Icons.person_outline_rounded, '我的'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      height: AppDimensions.bottomNavHeight + bottomPad,
      padding: EdgeInsets.only(bottom: bottomPad),
      child: Row(
        children: List.generate(_items.length, (i) {
          final selected = i == currentIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _items[i].icon,
                    size: 22,
                    color:
                        selected ? AppColors.pine : AppColors.muted,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _items[i].label,
                    style: AppTextStyles.caption.copyWith(
                      color: selected ? AppColors.pine : AppColors.muted,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: selected ? 4 : 0,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.pine,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
