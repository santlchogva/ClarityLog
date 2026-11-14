import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/data/evidence_data.dart';
import '../../shared/widgets/label_text.dart';

class EvidenceScreen extends StatelessWidget {
  final String evidenceId;
  const EvidenceScreen({super.key, required this.evidenceId});

  @override
  Widget build(BuildContext context) {
    final evidence = findEvidence(evidenceId);

    if (evidence == null) {
      return Scaffold(
        backgroundColor: AppColors.paper,
        appBar: AppBar(
          backgroundColor: AppColors.paper,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: Text('未找到此内容')),
      );
    }

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
        title: Text(evidence.type, style: AppTextStyles.note),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(evidence.title, style: AppTextStyles.h1),
            const SizedBox(height: 6),
            Text(evidence.summary,
                style: AppTextStyles.bodyLg.copyWith(
                    color: AppColors.pineMedium)),
            const SizedBox(height: 28),
            _Section(
              label: '建议',
              content: evidence.detail,
            ),
            const SizedBox(height: 20),
            _Section(
              label: '依据',
              content: evidence.rationale,
            ),
            const SizedBox(height: 20),
            _Section(
              label: '适用范围',
              content: evidence.scope,
            ),
            const SizedBox(height: 20),
            _Section(
              label: '局限性',
              content: evidence.limitations,
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.sage,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText('来源'),
                  const SizedBox(height: 6),
                  Text(evidence.sourceName,
                      style: AppTextStyles.bodySm),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => _launchUrl(evidence.sourceUrl),
                    child: Text(
                      '查看原始来源 →',
                      style: AppTextStyles.note.copyWith(
                        color: AppColors.pine,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('信息核对日期：${evidence.reviewDate}',
                      style: AppTextStyles.note),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.amberLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE8C8A8)),
              ),
              child: Text(
                '清志仅提供记录和信息参考功能，不提供医疗建议。内容不能替代专业医生的诊断和治疗意见。',
                style: AppTextStyles.note,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _Section extends StatelessWidget {
  final String label;
  final String content;
  const _Section({required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(label),
        const SizedBox(height: 6),
        Text(content, style: AppTextStyles.body),
      ],
    );
  }
}
