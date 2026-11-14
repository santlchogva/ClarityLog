import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/models/user_profile.dart';
import '../../core/providers/log_entry_provider.dart';
import '../../core/providers/user_profile_provider.dart';
import '../../shared/widgets/label_text.dart';
import '../me/widgets/profile_header_card.dart';
import '../me/widgets/settings_item_tile.dart';

class MeScreen extends ConsumerWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final allAsync = ref.watch(logEntriesProvider);
    final totalLogs = allAsync.valueOrNull?.length ?? 0;

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
            title: Text('我的', style: AppTextStyles.h2),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ProfileHeaderCard(
                    profile: profile,
                    onEdit: () => _showEditSheet(context, ref, profile),
                  ),
                  const SizedBox(height: 28),
                  _StatsRow(totalLogs: totalLogs),
                  const SizedBox(height: 28),
                  LabelText('功能'),
                  const Divider(height: 1, color: AppColors.border),
                  SettingsItemTile(
                    icon: Icons.calendar_today_outlined,
                    title: '月经周期追踪',
                    subtitle: profile.cycleTrackingEnabled ? '已开启' : '已关闭',
                    trailing: Switch(
                      value: profile.cycleTrackingEnabled,
                      onChanged: (v) => ref
                          .read(userProfileProvider.notifier)
                          .setCycleTracking(v),
                      activeColor: AppColors.pine,
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  if (profile.cycleTrackingEnabled)
                    SettingsItemTile(
                      icon: Icons.favorite_border_outlined,
                      title: '查看周期记录',
                      onTap: () => context.push('/cycle'),
                    ),
                  if (profile.cycleTrackingEnabled)
                    const Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: 20),
                  LabelText('关于'),
                  const Divider(height: 1, color: AppColors.border),
                  SettingsItemTile(
                    icon: Icons.info_outline,
                    title: '关于清志',
                    subtitle: '1.0.0',
                    onTap: () => _showAbout(context),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  SettingsItemTile(
                    icon: Icons.gavel_outlined,
                    title: '免责声明',
                    onTap: () => _showDisclaimer(context),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditSheet(
      BuildContext context, WidgetRef ref, UserProfile profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _EditProfileSheet(profile: profile),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.paper,
        title: Text('关于清志', style: AppTextStyles.subtitle),
        content: Text(
          '清志是一款帮助你记录和了解脑雾状态的个人工具。\n\n所有数据仅存储在你的设备上，不会上传到任何服务器。',
          style: AppTextStyles.bodySm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showDisclaimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.paper,
        title: Text('免责声明', style: AppTextStyles.subtitle),
        content: SingleChildScrollView(
          child: Text(
            '清志提供的所有内容（包括建议卡片）均为信息参考，不构成医疗建议，不能替代专业医生的诊断和治疗。\n\n如果你正在经历持续的健康困扰，请咨询医疗专业人员。',
            style: AppTextStyles.bodySm,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('了解'),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final int totalLogs;
  const _StatsRow({required this.totalLogs});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.sage,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('$totalLogs', style: AppTextStyles.h1),
                Text('总记录天数', style: AppTextStyles.note),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EditProfileSheet extends ConsumerStatefulWidget {
  final UserProfile profile;

  const _EditProfileSheet({required this.profile});

  @override
  ConsumerState<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<_EditProfileSheet> {
  late String _sex;
  late String _ageRange;

  static const _sexOptions = ['女', '男', '非二元/其他', '不愿透露'];
  static const _ageOptions = ['18-25岁', '26-35岁', '36-45岁', '46-55岁', '56岁以上'];

  @override
  void initState() {
    super.initState();
    _sex = widget.profile.sex.isNotEmpty ? widget.profile.sex : '不愿透露';
    _ageRange = widget.profile.ageRange.isNotEmpty ? widget.profile.ageRange : '26-35岁';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('编辑资料', style: AppTextStyles.h2),
          const SizedBox(height: 20),
          Text('性别', style: AppTextStyles.subtitle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _sexOptions.map((s) {
              final selected = _sex == s;
              return ChoiceChip(
                label: Text(s),
                selected: selected,
                onSelected: (_) => setState(() => _sex = s),
                selectedColor: AppColors.pine,
                labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.inkMed),
                showCheckmark: false,
                side: BorderSide.none,
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text('年龄段', style: AppTextStyles.subtitle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _ageOptions.map((a) {
              final selected = _ageRange == a;
              return ChoiceChip(
                label: Text(a),
                selected: selected,
                onSelected: (_) => setState(() => _ageRange = a),
                selectedColor: AppColors.pine,
                labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.inkMed),
                showCheckmark: false,
                side: BorderSide.none,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () async {
                await ref.read(userProfileProvider.notifier).update(
                      widget.profile.copyWith(sex: _sex, ageRange: _ageRange),
                    );
                if (context.mounted) Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pine,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('保存', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}
