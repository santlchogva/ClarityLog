import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/models/activity_entry.dart';
import '../../core/providers/activity_entry_provider.dart';
import '../../shared/widgets/label_text.dart';
import '../../shared/widgets/primary_button.dart';
import '../activity/widgets/activity_type_selector.dart';
import '../activity/widgets/pem_question_card.dart';

const _uuid = Uuid();

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  String? _activityType;
  int _duration = 20;
  int _intensity = 2;
  bool? _pem;
  bool _saving = false;

  Future<void> _save() async {
    if (_activityType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先选择活动类型')),
      );
      return;
    }
    setState(() => _saving = true);
    final now = DateTime.now();
    final entry = ActivityEntry(
      id: _uuid.v4(),
      loggedAt: now,
      activityType: _activityType!,
      durationMinutes: _duration,
      intensityLevel: _intensity,
      postExertionMalaise: _pem,
      createdAt: now,
      updatedAt: now,
    );
    await ref.read(activityEntriesProvider.notifier).add(entry);
    setState(() => _saving = false);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final hasPemWarning = ref.watch(hasPemProvider).valueOrNull ?? false;

    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
        title: Text('记录活动', style: AppTextStyles.h2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            if (hasPemWarning) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE8C8A8)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_outlined,
                        color: AppColors.amber, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '近 3 天有活动后不适记录，建议今日避免增加运动量。',
                        style: AppTextStyles.note,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            LabelText('活动类型'),
            const SizedBox(height: 10),
            ActivityTypeSelector(
              selected: _activityType,
              onChanged: (v) => setState(() => _activityType = v),
            ),
            const SizedBox(height: 24),
            LabelText('时长（分钟）'),
            const SizedBox(height: 10),
            _DurationRow(
              value: _duration,
              onChanged: (v) => setState(() => _duration = v),
            ),
            const SizedBox(height: 24),
            LabelText('强度 $_intensity / 5'),
            const SizedBox(height: 4),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbColor: AppColors.pine,
                activeTrackColor: AppColors.pine,
                inactiveTrackColor: AppColors.sage,
                overlayColor: AppColors.pine.withOpacity(0.1),
              ),
              child: Slider(
                value: _intensity.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (v) => setState(() => _intensity = v.round()),
              ),
            ),
            const SizedBox(height: 24),
            LabelText('活动后反应'),
            const SizedBox(height: 10),
            PemQuestionCard(
              answer: _pem,
              onChanged: (v) => setState(() => _pem = v),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: _saving ? '保存中…' : '保存记录',
              onPressed: _saving ? null : _save,
              mode: ButtonMode.full,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _DurationRow extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _DurationRow({required this.value, required this.onChanged});

  static const _opts = [10, 20, 30, 45, 60, 90];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _opts.map((d) {
        final selected = value == d;
        return GestureDetector(
          onTap: () => onChanged(d),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: selected ? AppColors.pine : AppColors.sage,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${d}分',
              style: AppTextStyles.chipLabel.copyWith(
                  color: selected ? Colors.white : AppColors.inkMed),
            ),
          ),
        );
      }).toList(),
    );
  }
}
