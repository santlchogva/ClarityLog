import '../../core/constants/app_colors.dart';
import 'package:flutter/material.dart';

Color scoreColor(int score) => AppColors.scoreColor(score);

String scoreLabel(int score) {
  if (score >= 7) return '状态不错';
  if (score >= 4) return '有些模糊';
  return '比较困难';
}
