import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_profile_provider.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/today/today_screen.dart';
import '../../features/log/log_screen.dart';
import '../../features/food/food_screen.dart';
import '../../features/activity/activity_screen.dart';
import '../../features/insight/insight_screen.dart';
import '../../features/me/me_screen.dart';
import '../../features/evidence/evidence_screen.dart';
import '../../features/cycle/cycle_screen.dart';
import '../../shared/widgets/app_scaffold.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/today',
    redirect: (context, state) {
      final profile = ref.read(userProfileProvider);
      final onboarded = profile.onboardingCompleted;
      final goingToOnboard =
          state.matchedLocation.startsWith('/onboarding');
      if (!onboarded && !goingToOnboard) return '/onboarding';
      if (onboarded && goingToOnboard) return '/today';
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
        ref.watch(userProfileProvider.notifier).stream),
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            AppScaffold(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/today',
              builder: (_, __) => const TodayScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/log',
              builder: (_, __) => const LogScreen(),
              routes: [
                GoRoute(
                  path: 'food',
                  builder: (_, __) => const FoodScreen(),
                ),
                GoRoute(
                  path: 'activity',
                  builder: (_, __) => const ActivityScreen(),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/insight',
              builder: (_, __) => const InsightScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/me',
              builder: (_, __) => const MeScreen(),
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/evidence/:id',
        builder: (_, state) =>
            EvidenceScreen(evidenceId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/cycle',
        builder: (_, __) => const CycleScreen(),
      ),
    ],
  );
});

/// Bridges a Riverpod [StateNotifier]'s stream to [Listenable] for go_router.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _sub = stream.listen((_) => notifyListeners());
  }

  late final dynamic _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
