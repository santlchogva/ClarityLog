import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/data/evidence_data.dart';
import '../../core/providers/log_entry_provider.dart';
import '../../core/providers/activity_entry_provider.dart';
import '../../shared/widgets/label_text.dart';
import '../insight/widgets/insight_chart.dart';
import '../insight/widgets/coverage_bar.dart';
import '../insight/widgets/correlation_card.dart';
import '../today/widgets/suggestion_card.dart';

class InsightScreen extends ConsumerWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyAsync = ref.watch(weeklyScoresProvider);
    final hasPem = ref.watch(hasPemProvider).valueOrNull ?? false;

    final weekly = weeklyAsync.valueOrNull;

    final loggedDays = weekly?.where((e) => e != null).length ?? 0;

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.paper,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            pinned: false,
            expandedHeight: 0,
            title: Text('洞察', style: AppTextStyles.h2),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  CoverageBar(loggedDays: loggedDays, totalDays: 7),
                  const SizedBox(height: 24),
                  LabelText('过去 7 天趋势'),
                  const SizedBox(height: 10),
                  if (weekly != null)
                    InsightChart(entries: weekly)
                  else
                    _EmptyChart(),
                  const SizedBox(height: 28),
                  if (weekly != null) ...[
                    CorrelationCard(entries: weekly),
                    const SizedBox(height: 28),
                  ],
                  LabelText('建议参考'),
                  const SizedBox(height: 10),
                  ...kEvidenceList.where((e) {
                    if (hasPem && e.id == 'pem_activity') return false;
                    return true;
                  }).map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SuggestionCard(
                          evidence: e,
                          onTap: () => context.push('/evidence/${e.id}'),
                        ),
                      )),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Center(
        child: Text('开始记录，这里将展示趋势图表', style: AppTextStyles.note),
      ),
    );
  }
}
