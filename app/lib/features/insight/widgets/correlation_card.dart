import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/log_entry.dart';
import '../../../shared/widgets/card_base.dart';

class CorrelationCard extends StatelessWidget {
  final List<LogEntry?> entries;

  const CorrelationCard({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final logged = entries.where((e) => e != null).length;

    if (logged < 5) {
      return CardBase(
        variant: CardVariant.sage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('先积累，再看规律', style: AppTextStyles.subtitle),
            const SizedBox(height: 6),
            Text(
              '当前真实记录 $logged 天。图表仅供参考，请继续记录以积累足够数据。',
              style: AppTextStyles.bodySm,
            ),
          ],
        ),
      );
    }

    final withSleep = entries
        .where((e) => e != null && e.sleepHours != null)
        .cast<LogEntry>()
        .toList();

    if (withSleep.length < 4) {
      return CardBase(
        variant: CardVariant.sage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('补充睡眠数据，观察更多联系', style: AppTextStyles.subtitle),
            const SizedBox(height: 6),
            Text('在记录中加入睡眠时长，可以观察睡眠与清晰度是否有个人关联。',
                style: AppTextStyles.bodySm),
          ],
        ),
      );
    }

    final avgSleep = withSleep
            .map((e) => e.sleepHours!)
            .reduce((a, b) => a + b) /
        withSleep.length;

    final longSleepScores = withSleep
        .where((e) => e.sleepHours! >= avgSleep)
        .map((e) => e.score)
        .toList();
    final shortSleepScores = withSleep
        .where((e) => e.sleepHours! < avgSleep)
        .map((e) => e.score)
        .toList();

    if (longSleepScores.isEmpty || shortSleepScores.isEmpty) {
      return const SizedBox.shrink();
    }

    final avgLong =
        longSleepScores.reduce((a, b) => a + b) / longSleepScores.length;
    final avgShort = shortSleepScores.reduce((a, b) => a + b) /
        shortSleepScores.length;

    final diff = (avgLong - avgShort).abs();
    if (diff < 0.5) {
      return const SizedBox.shrink();
    }

    final moreText = avgLong > avgShort ? '较高' : '较低';

    return CardBase(
      variant: CardVariant.sage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('可能的个人联系', style: AppTextStyles.subtitle),
          const SizedBox(height: 6),
          Text(
            '睡眠较长的记录日，你的清晰度自评也$moreText。记录仍少，不能说明因果。',
            style: AppTextStyles.bodySm,
          ),
          const SizedBox(height: 4),
          Text('样本：${withSleep.length} 条记录 · 仅供本人参考',
              style: AppTextStyles.note),
        ],
      ),
    );
  }
}
