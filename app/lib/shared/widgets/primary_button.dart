import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool fullWidth;
  final bool outlined;
  final bool textOnly;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.fullWidth = false,
    this.outlined = false,
    this.textOnly = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (textOnly) {
      return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.pine,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label, style: AppTextStyles.body.copyWith(color: AppColors.pine)),
      );
    }

    final bg = outlined ? Colors.transparent : AppColors.pine;
    final fg = outlined ? AppColors.pine : Colors.white;
    final border = outlined
        ? BorderSide(color: AppColors.border, width: 1.5)
        : BorderSide.none;

    Widget content = icon != null
        ? Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 18, color: fg),
            const SizedBox(width: 6),
            Text(label, style: AppTextStyles.button.copyWith(color: fg)),
          ])
        : Text(label, style: AppTextStyles.button.copyWith(color: fg));

    final btn = ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        minimumSize: Size(fullWidth ? double.infinity : 0,
            AppDimensions.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.radiusXl),
          side: border,
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: content,
    );

    return fullWidth
        ? SizedBox(width: double.infinity, child: btn)
        : btn;
  }
}
