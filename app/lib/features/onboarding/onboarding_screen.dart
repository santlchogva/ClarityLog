import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/user_profile_provider.dart';
import 'widgets/onboarding_step1.dart';
import 'widgets/onboarding_step2.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: _step == 0 ? 0.5 : 1.0,
                        backgroundColor: AppColors.sage,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(AppColors.pine),
                        minHeight: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: _step == 0
                    ? OnboardingStep1(
                        key: const ValueKey(0),
                        onNext: () => setState(() => _step = 1),
                      )
                    : OnboardingStep2(
                        key: const ValueKey(1),
                        initial: profile,
                        onComplete: (p) async {
                          await ref
                              .read(userProfileProvider.notifier)
                              .update(p);
                          if (context.mounted) context.go('/today');
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
