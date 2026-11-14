import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const pine = Color(0xFF2A5440);
  static const pineDark = Color(0xFF1E3D2F);
  static const pineMedium = Color(0xFF5A9478);
  static const pineLight = Color(0xFF4A7C63);

  static const paper = Color(0xFFF7F4EE);
  static const white = Color(0xFFFDFCF9);

  static const sage = Color(0xFFE6EDE0);
  static const sageMed = Color(0xFFC5D5BD);
  static const sageDark = Color(0xFFA8BFA0);

  static const amber = Color(0xFFC4784A);
  static const amberLight = Color(0xFFF4EAD8);

  static const ink = Color(0xFF1A2E24);
  static const inkMed = Color(0xFF3D5547);
  static const muted = Color(0xFF718A7A);

  static const border = Color(0xFFDDE5D8);
  static const borderMed = Color(0xFFC8D5C0);

  // Period / cycle accent
  static const period = Color(0xFF8B4A4A);
  static const periodBorder = Color(0xFFC47878);
  static const periodLight = Color(0xFFEADBD6);

  // Semantic
  static const scoreHigh = pine;
  static const scoreMid = pineMedium;
  static const scoreLow = amber;

  static Color scoreColor(int score) {
    if (score >= 7) return scoreHigh;
    if (score >= 4) return scoreMid;
    return scoreLow;
  }
}
