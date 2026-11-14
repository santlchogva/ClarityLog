import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';

class LabelText extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;

  const LabelText(this.text, {super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    Widget child = Text(
      text.toUpperCase(),
      style: AppTextStyles.label,
    );
    if (padding != null) {
      child = Padding(padding: padding!, child: child);
    }
    return child;
  }
}
