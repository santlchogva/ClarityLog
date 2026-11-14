import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/data/evidence_data.dart';
import '../../core/providers/log_entry_provider.dart';
import '../../shared/utils/score_color_util.dart';
import '../../shared/widgets/label_text.dart';
import '../today/widgets/score_ring.dart';
import '../today/widgets/weekly_trend_chart.dart';
import '../today/widgets/suggestion_card.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAsync = ref.watch(todayLogEntryProvider);
    final weeklyAsync = ref.watch(weeklyScoresProvider);

    final today = todayAsync.valueOrNull;
    final weekly = weeklyAsync.valueOrNull;

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
            title: Text('清志', style: AppTextStyles.h2),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    color: AppColors.pine),
                tooltip: '记录今日',
                onPressed: () => context.go('/log'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _ScoreSection(today: today?.score),
                  const SizedBox(height: 28),
                  if (today != null) ...[
                    _SymptomsSection(symptoms: today.symptoms),
                    const SizedBox(height: 28),
                  ],
                  LabelText('过去 7 天'),
                  const SizedBox(height: 10),
                  if (weekly != null)
                    WeeklyTrendChart(entries: weekly)
                  else
                    const SizedBox(height: 90),
                  const SizedBox(height: 28),
                  LabelText('今日提示'),
                  const SizedBox(height: 10),
                  _SuggestionList(hasPem: false),
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

class _ScoreSection extends StatelessWidget {
  final int? today;
  const _ScoreSection({this.today});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScoreRing(score: today ?? 0),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                today == null ? '今天还没有记录' : '清晰度 ${scoreLabel(today!)}',
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 6),
              Text(
                today == null
                    ? '点击右上角 + 记录今天的感受'
                    : '已记录今日状态',
                style: AppTextStyles.note,
              ),
              const SizedBox(height: 10),
              if (today == null)
                GestureDetector(
                  onTap: () => context.go('/log'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.pine,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('立即记录',
                        style: AppTextStyles.button
                            .copyWith(fontSize: 13)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SymptomsSection extends StatelessWidget {
  final List<String> symptoms;
  const _SymptomsSection({required this.symptoms});

  @override
  Widget build(BuildContext context) {
    if (symptoms.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText('今日症状'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: symptoms.map((s) {
            return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.sage,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(s, style: AppTextStyles.chipLabel),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SuggestionList extends StatelessWidget {
  final bool hasPem;
  const _SuggestionList({required this.hasPem});

  @override
  Widget build(BuildContext context) {
    final filtered = kEvidenceList.where((e) {
      if (hasPem && e.id == 'pem_activity') return false;
      return true;
    }).take(3).toList();

    return Column(
      children: filtered.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SuggestionCard(
            evidence: e,
            onTap: () => context.push('/evidence/${e.id}'),
          ),
        );
      }).toList(),
    );
  }
}
