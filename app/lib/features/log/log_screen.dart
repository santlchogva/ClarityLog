import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/models/log_entry.dart';
import '../../core/providers/log_entry_provider.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/label_text.dart';
import '../log/widgets/score_slider_card.dart';
import '../log/widgets/symptom_chip_selector.dart';

const _uuid = Uuid();

class LogScreen extends ConsumerStatefulWidget {
  const LogScreen({super.key});

  @override
  ConsumerState<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends ConsumerState<LogScreen> {
  int _score = 5;
  List<String> _symptoms = [];
  double? _sleepHours;
  int? _stressLevel;
  late final TextEditingController _noteController;
  bool _saving = false;

  Future<void> _save() async {
    setState(() => _saving = true);
    final todayVal = ref.read(todayLogEntryProvider).valueOrNull;
    final notifier = ref.read(logEntriesProvider.notifier);
    final now = DateTime.now();
    final note = _noteController.text.trim();

    if (todayVal != null) {
      await notifier.updateEntry(todayVal.copyWith(
        score: _score,
        symptoms: _symptoms,
        sleepHours: _sleepHours,
        stressLevel: _stressLevel,
        note: note.isNotEmpty ? note : null,
        updatedAt: now,
      ));
    } else {
      await notifier.add(LogEntry(
        id: _uuid.v4(),
        loggedAt: now,
        score: _score,
        symptoms: _symptoms,
        sleepHours: _sleepHours,
        stressLevel: _stressLevel,
        note: note.isNotEmpty ? note : null,
        isLowEnergyMode: false,
        createdAt: now,
        updatedAt: now,
      ));
    }

    setState(() => _saving = false);
    if (mounted) context.go('/today');
  }

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = ref.read(todayLogEntryProvider).valueOrNull;
      if (today != null) {
        setState(() {
          _score = today.score;
          _symptoms = List.from(today.symptoms);
          _sleepHours = today.sleepHours;
          _stressLevel = today.stressLevel;
          _noteController.text = today.note ?? '';
        });
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text('记录今日', style: AppTextStyles.h2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.go('/today'),
        ),
        actions: [
          TextButton(
            onPressed: () => context.push('/log/food'),
            child: Text('饮食', style: AppTextStyles.bodySm.copyWith(color: AppColors.pine)),
          ),
          TextButton(
            onPressed: () => context.push('/log/activity'),
            child: Text('活动', style: AppTextStyles.bodySm.copyWith(color: AppColors.pine)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            LabelText('清晰度评分'),
            const SizedBox(height: 10),
            ScoreSliderCard(
              score: _score,
              onChanged: (v) => setState(() => _score = v),
            ),
            const SizedBox(height: 24),
            LabelText('今天的症状'),
            const SizedBox(height: 10),
            SymptomChipSelector(
              selected: _symptoms,
              onChanged: (v) => setState(() => _symptoms = v),
            ),
            const SizedBox(height: 24),
            LabelText('睡眠时长（可选）'),
            const SizedBox(height: 10),
            _SleepRow(
              value: _sleepHours,
              onChanged: (v) => setState(() => _sleepHours = v),
            ),
            const SizedBox(height: 24),
            LabelText('压力感受（可选）'),
            const SizedBox(height: 10),
            _StressRow(
              value: _stressLevel,
              onChanged: (v) => setState(() => _stressLevel = v),
            ),
            const SizedBox(height: 24),
            LabelText('补充备注（可选）'),
            const SizedBox(height: 10),
            TextField(
              maxLines: 3,
              minLines: 2,
              controller: _noteController,
              decoration: InputDecoration(
                hintText: '今天还有什么想记下来的？',
                hintStyle: AppTextStyles.note,
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: AppColors.pine),
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
              style: AppTextStyles.bodySm,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: _saving ? '保存中…' : '保存记录',
              onTap: _saving ? null : _save,
              fullWidth: true,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _SleepRow extends StatelessWidget {
  final double? value;
  final ValueChanged<double?> onChanged;
  const _SleepRow({this.value, required this.onChanged});

  static const _opts = [4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _opts.map((h) {
        final label = '${h.toInt()}h';
        final selected = value == h;
        return GestureDetector(
          onTap: () => onChanged(selected ? null : h),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: selected ? AppColors.pine : AppColors.sage,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: AppTextStyles.chipLabel.copyWith(
                  color: selected ? Colors.white : AppColors.inkMed),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StressRow extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;
  const _StressRow({this.value, required this.onChanged});

  static const _labels = ['极低', '低', '中', '高', '极高'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: List.generate(5, (i) {
        final v = i + 1;
        final selected = value == v;
        return GestureDetector(
          onTap: () => onChanged(selected ? null : v),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: selected ? AppColors.pine : AppColors.sage,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _labels[i],
              style: AppTextStyles.chipLabel.copyWith(
                  color: selected ? Colors.white : AppColors.inkMed),
            ),
          ),
        );
      }),
    );
  }
}
