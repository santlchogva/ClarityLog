import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Display — NotoSerifSC
  static const TextStyle display = TextStyle(
    fontFamily: 'NotoSerifSC',
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
    height: 1.25,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: 'NotoSerifSC',
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
    height: 1.35,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'NotoSerifSC',
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
    height: 1.4,
  );

  // Body — system sans
  static const TextStyle bodyLg = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.inkMed,
    height: 1.65,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.inkMed,
    height: 1.65,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.inkMed,
    height: 1.6,
  );

  static const TextStyle note = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.muted,
    height: 1.5,
  );

  // Labels & UI
  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.muted,
    letterSpacing: 2.5,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle chipLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1,
  );

  // Score ring center
  static const TextStyle scoreNum = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    height: 1,
  );

  static const TextStyle scoreSub = TextStyle(
    fontSize: 11,
    color: AppColors.muted,
    height: 1,
  );

  // Chart tooltip
  static const TextStyle tooltip = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 10,
    color: AppColors.muted,
    height: 1,
  );

  // Settings item
  static const TextStyle settingTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const TextStyle settingSub = TextStyle(
    fontSize: 12,
    color: AppColors.muted,
  );
}
