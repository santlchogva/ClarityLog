import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/log_entry.dart';
import '../../../shared/utils/date_format_util.dart';

class WeeklyTrendChart extends StatelessWidget {
  /// 7 entries, null means no log that day. Index 0 = 6 days ago, 6 = today.
  final List<LogEntry?> entries;

  const WeeklyTrendChart({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final labels = last7DayLabels();
    final spots = <FlSpot>[];
    int lastValidX = 0;

    for (int i = 0; i < entries.length; i++) {
      if (entries[i] != null) {
        spots.add(FlSpot(i.toDouble(), entries[i]!.score.toDouble()));
        lastValidX = i;
      }
    }

    if (spots.isEmpty) {
      return _emptyState();
    }

    return SizedBox(
      height: 90,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 10,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: AppColors.pine,
              barWidth: 2.5,
              dotData: FlDotData(
                checkToShowDot: (spot, _) =>
                    spot.x.toInt() == lastValidX,
                getDotPainter: (spot, _, __, ___) =>
                    FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.pine,
                  strokeWidth: 2,
                  strokeColor: AppColors.white,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.pine.withOpacity(0.18),
                    AppColors.pine.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 20,
                getTitlesWidget: (value, _) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    labels[value.toInt()],
                    style: AppTextStyles.caption,
                  ),
                ),
              ),
            ),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => AppColors.pine,
              getTooltipItems: (spots) => spots
                  .map((s) => LineTooltipItem(
                        '${s.y.toInt()} 分',
                        AppTextStyles.tooltip,
                      ))
                  .toList(),
            ),
          ),
        ),
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  Widget _emptyState() {
    return SizedBox(
      height: 60,
      child: Center(
        child: Text('记录更多天，趋势图会出现这里。',
            style: AppTextStyles.note),
      ),
    );
  }
}
