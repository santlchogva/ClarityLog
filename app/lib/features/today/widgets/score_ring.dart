import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/utils/score_color_util.dart';

class ScoreRing extends StatelessWidget {
  final int score;
  final double size;

  const ScoreRing({super.key, required this.score, this.size = 124});

  @override
  Widget build(BuildContext context) {
    final color = scoreColor(score);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: score / 10.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, progress, _) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _RingPainter(
            progress: progress,
            arcColor: color,
            score: score,
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color arcColor;
  final int score;

  _RingPainter({
    required this.progress,
    required this.arcColor,
    required this.score,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 7;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Track
    canvas.drawArc(
      rect,
      0,
      2 * pi,
      false,
      Paint()
        ..color = AppColors.sage
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );

    // Progress arc
    if (progress > 0) {
      canvas.drawArc(
        rect,
        -pi / 2,
        2 * pi * progress,
        false,
        Paint()
          ..color = arcColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round,
      );
    }

    // Score number
    _drawText(
      canvas,
      '$score',
      center.translate(0, -10),
      AppTextStyles.scoreNum,
    );

    // "/10"
    _drawText(
      canvas,
      '/ 10',
      center.translate(0, 8),
      AppTextStyles.scoreSub,
    );

    // Label
    _drawText(
      canvas,
      scoreLabel(score),
      center.translate(0, 24),
      AppTextStyles.scoreSub.copyWith(color: arcColor),
    );
  }

  void _drawText(
      Canvas canvas, String text, Offset center, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center.translate(-tp.width / 2, -tp.height / 2));
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.arcColor != arcColor ||
      old.score != score;
}
