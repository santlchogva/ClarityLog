import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/providers/period_provider.dart';
import '../../shared/utils/symptoms_constants.dart';
import '../../shared/widgets/label_text.dart';
import '../../shared/widgets/primary_button.dart';
import '../cycle/widgets/period_record_tile.dart';

class CycleScreen extends ConsumerStatefulWidget {
  const CycleScreen({super.key});

  @override
  ConsumerState<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends ConsumerState<CycleScreen> {
  bool _showForm = false;

  DateTime? _startDate;
  DateTime? _endDate;
  String _flowLevel = '中';
  String _painLevel = '无';
  String? _formError;

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final initial = isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.pine,
            onPrimary: Colors.white,
            surface: AppColors.paper,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
        _formError = null;
      });
    }
  }

  Future<void> _save() async {
    if (_startDate == null) {
      setState(() => _formError = '请选择开始日期');
      return;
    }
    if (_endDate != null && _endDate!.isBefore(_startDate!)) {
      setState(() => _formError = '结束日期不能早于开始日期');
      return;
    }
    final notifier = ref.read(periodEntriesProvider.notifier);
    final entry = notifier.createNew(
      startDate: _startDate!,
      endDate: _endDate,
      flowLevel: _flowLevel,
      painLevel: _painLevel,
    );
    final ok = await notifier.add(entry);
    if (!ok) {
      setState(() => _formError = '该时间段与已有记录重叠，请检查日期');
      return;
    }
    setState(() {
      _showForm = false;
      _startDate = null;
      _endDate = null;
      _flowLevel = '中';
      _painLevel = '无';
      _formError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(periodEntriesProvider);
    final entries = entriesAsync.valueOrNull ?? [];

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
        title: Text('月经周期', style: AppTextStyles.h2),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.periodLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '月经数据仅存储在你的设备上，不会上传。可在设置中随时关闭此功能。',
              style: AppTextStyles.note,
            ),
          ),
          const SizedBox(height: 20),
          if (!_showForm)
            PrimaryButton(
              label: '添加记录',
              onTap: () => setState(() => _showForm = true),
              fullWidth: true,
              outlined: true,
            ),
          if (_showForm) ...[
            const SizedBox(height: 8),
            _AddPeriodForm(
              startDate: _startDate,
              endDate: _endDate,
              flowLevel: _flowLevel,
              painLevel: _painLevel,
              error: _formError,
              onPickStart: () => _pickDate(context, true),
              onPickEnd: () => _pickDate(context, false),
              onFlowChanged: (v) => setState(() => _flowLevel = v),
              onPainChanged: (v) => setState(() => _painLevel = v),
              onSave: _save,
              onCancel: () => setState(() {
                _showForm = false;
                _formError = null;
              }),
            ),
          ],
          const SizedBox(height: 24),
          if (entries.isNotEmpty) ...[
            LabelText('历史记录'),
            const SizedBox(height: 4),
            ...entries.map((e) => PeriodRecordTile(
                  entry: e,
                  onDelete: () =>
                      ref.read(periodEntriesProvider.notifier).remove(e.id),
                )),
          ] else if (!_showForm)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text('还没有周期记录', style: AppTextStyles.note),
              ),
            ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _AddPeriodForm extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String flowLevel;
  final String painLevel;
  final String? error;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;
  final ValueChanged<String> onFlowChanged;
  final ValueChanged<String> onPainChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const _AddPeriodForm({
    this.startDate,
    this.endDate,
    required this.flowLevel,
    required this.painLevel,
    this.error,
    required this.onPickStart,
    required this.onPickEnd,
    required this.onFlowChanged,
    required this.onPainChanged,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('新记录', style: AppTextStyles.subtitle),
          const SizedBox(height: 14),
          _DateRow(
            label: '开始日期',
            date: startDate,
            onTap: onPickStart,
          ),
          const SizedBox(height: 10),
          _DateRow(
            label: '结束日期（可选，不填表示持续中）',
            date: endDate,
            onTap: onPickEnd,
          ),
          const SizedBox(height: 16),
          Text('出血量', style: AppTextStyles.bodySm),
          const SizedBox(height: 8),
          _ChipRow(
            options: kFlowLevels,
            selected: flowLevel,
            onChanged: onFlowChanged,
          ),
          const SizedBox(height: 14),
          Text('疼痛程度', style: AppTextStyles.bodySm),
          const SizedBox(height: 8),
          _ChipRow(
            options: kPainLevels,
            selected: painLevel,
            onChanged: onPainChanged,
          ),
          if (error != null) ...[
            const SizedBox(height: 10),
            Text(error!,
                style: AppTextStyles.note
                    .copyWith(color: AppColors.amber)),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: '取消',
                  onTap: onCancel,
                  fullWidth: true,
                  outlined: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: '保存',
                  onTap: onSave,
                  fullWidth: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DateRow({required this.label, this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final display = date == null
        ? '点击选择'
        : '${date!.year}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.sage,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: AppTextStyles.note)),
            Text(display,
                style: AppTextStyles.bodySm.copyWith(
                    color: date == null ? AppColors.muted : AppColors.ink)),
          ],
        ),
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;

  const _ChipRow({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((o) {
        final isSelected = selected == o;
        return GestureDetector(
          onTap: () => onChanged(o),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.period : AppColors.sage,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              o,
              style: AppTextStyles.chipLabel.copyWith(
                  color: isSelected ? Colors.white : AppColors.inkMed),
            ),
          ),
        );
      }).toList(),
    );
  }
}
