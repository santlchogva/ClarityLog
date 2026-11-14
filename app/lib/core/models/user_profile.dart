import 'dart:convert';

class UserProfile {
  final String sex;
  final String ageRange;
  final bool cycleTrackingEnabled;
  final bool onboardingCompleted;
  final String? dailyReminderTime;

  const UserProfile({
    this.sex = '',
    this.ageRange = '',
    this.cycleTrackingEnabled = false,
    this.onboardingCompleted = false,
    this.dailyReminderTime,
  });

  static const UserProfile defaults = UserProfile();

  Map<String, dynamic> toJson() => {
        'sex': sex,
        'age_range': ageRange,
        'cycle_tracking_enabled': cycleTrackingEnabled,
        'onboarding_completed': onboardingCompleted,
        'daily_reminder_time': dailyReminderTime,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        sex: json['sex'] as String? ?? '',
        ageRange: json['age_range'] as String? ?? '',
        cycleTrackingEnabled:
            json['cycle_tracking_enabled'] as bool? ?? false,
        onboardingCompleted:
            json['onboarding_completed'] as bool? ?? false,
        dailyReminderTime: json['daily_reminder_time'] as String?,
      );

  String toJsonString() => jsonEncode(toJson());

  factory UserProfile.fromJsonString(String s) =>
      UserProfile.fromJson(jsonDecode(s) as Map<String, dynamic>);

  UserProfile copyWith({
    String? sex,
    String? ageRange,
    bool? cycleTrackingEnabled,
    bool? onboardingCompleted,
    String? dailyReminderTime,
  }) =>
      UserProfile(
        sex: sex ?? this.sex,
        ageRange: ageRange ?? this.ageRange,
        cycleTrackingEnabled:
            cycleTrackingEnabled ?? this.cycleTrackingEnabled,
        onboardingCompleted:
            onboardingCompleted ?? this.onboardingCompleted,
        dailyReminderTime: dailyReminderTime ?? this.dailyReminderTime,
      );

  String ageContextNote() {
    if (ageRange == '65 岁及以上') {
      return '记录变化是否影响熟悉的日常任务；持续或加重时寻求专业评估，不要仅归因于年龄。';
    }
    if (ageRange == '45–54 岁' || ageRange == '55–64 岁') {
      return '可补充睡眠、用药变化与生活阶段；如有周期变化，可选择记录。年龄不能判断原因。';
    }
    return '先观察睡眠、压力、饮食与症状出现的时间。年龄只帮助调整提问，不用于推断病因。';
  }
}
