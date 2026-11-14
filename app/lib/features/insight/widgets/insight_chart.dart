import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/log_entry.dart';
import '../../../shared/utils/date_format_util.dart';

class InsightChart extends StatelessWidget {
  final List<LogEntry?> entries;
  final String rangeLabel;

  const InsightChart({
    super.key,
    required this.entries,
    this.rangeLabel = '7 天',
  });

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
      return Center(
          child: Text('暂无数据', style: AppTextStyles.note));
    }

    return SizedBox(
      height: 110,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: entries.length.toDouble() - 1,
          minY: 0,
          maxY: 10,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.35,
              color: AppColors.pine,
              barWidth: 2.5,
              dotData: FlDotData(
                checkToShowDot: (s, _) => s.x.toInt() == lastValidX,
                getDotPainter: (_, __, ___, ____) =>
                    FlDotCirclePainter(
                  radius: 5,
                  color: AppColors.pine,
                  strokeWidth: 2.5,
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
                getTitlesWidget: (v, _) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(labels[v.toInt() % labels.length],
                      style: AppTextStyles.caption),
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
}
