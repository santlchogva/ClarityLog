import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

enum CardVariant { white, sage, amber, pine }

class CardBase extends StatelessWidget {
  final Widget child;
  final CardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const CardBase({
    super.key,
    required this.child,
    this.variant = CardVariant.white,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = switch (variant) {
      CardVariant.white => AppColors.white,
      CardVariant.sage => AppColors.sage,
      CardVariant.amber => AppColors.amberLight,
      CardVariant.pine => AppColors.pine,
    };
    final borderColor = switch (variant) {
      CardVariant.white => AppColors.border,
      CardVariant.sage => AppColors.sageMed,
      CardVariant.amber => const Color(0xFFE8C8A8),
      CardVariant.pine => AppColors.pineDark,
    };
    final hasShadow =
        variant == CardVariant.white || variant == CardVariant.pine;

    Widget card = Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        border: Border.all(color: borderColor),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: AppColors.ink.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppDimensions.cardPaddingH,
            vertical: AppDimensions.cardPaddingV,
          ),
      child: child,
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: card,
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 12),
      child: card,
    );
  }
}
