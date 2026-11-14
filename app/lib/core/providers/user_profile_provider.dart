import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

const _prefKey = 'user_profile';

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(UserProfile.defaults);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefKey);
    if (raw != null) {
      state = UserProfile.fromJsonString(raw);
    }
  }

  Future<void> update(UserProfile profile) async {
    state = profile;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, profile.toJsonString());
  }

  Future<void> markOnboardingComplete() async {
    await update(state.copyWith(onboardingCompleted: true));
  }

  Future<void> setCycleTracking(bool enabled) async {
    await update(state.copyWith(cycleTrackingEnabled: enabled));
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  final notifier = UserProfileNotifier();
  notifier.load();
  return notifier;
});
