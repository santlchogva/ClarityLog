class ActivityEntry {
  final String id;
  final DateTime loggedAt;
  final String activityType;
  final int durationMinutes;
  final int intensityLevel;
  final bool? postExertionMalaise;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ActivityEntry({
    required this.id,
    required this.loggedAt,
    required this.activityType,
    required this.durationMinutes,
    required this.intensityLevel,
    this.postExertionMalaise,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'logged_at': loggedAt.millisecondsSinceEpoch,
        'activity_type': activityType,
        'duration_minutes': durationMinutes,
        'intensity_level': intensityLevel,
        'post_exertion_malaise': postExertionMalaise == null
            ? null
            : (postExertionMalaise! ? 1 : 0),
        'note': note,
        'created_at': createdAt.millisecondsSinceEpoch,
        'updated_at': updatedAt.millisecondsSinceEpoch,
      };

  factory ActivityEntry.fromMap(Map<String, dynamic> map) {
    final pemRaw = map['post_exertion_malaise'] as int?;
    return ActivityEntry(
      id: map['id'] as String,
      loggedAt:
          DateTime.fromMillisecondsSinceEpoch(map['logged_at'] as int),
      activityType: map['activity_type'] as String,
      durationMinutes: map['duration_minutes'] as int,
      intensityLevel: map['intensity_level'] as int,
      postExertionMalaise: pemRaw == null ? null : pemRaw == 1,
      note: map['note'] as String?,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt:
          DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  ActivityEntry copyWith({
    String? id,
    DateTime? loggedAt,
    String? activityType,
    int? durationMinutes,
    int? intensityLevel,
    bool? postExertionMalaise,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ActivityEntry(
        id: id ?? this.id,
        loggedAt: loggedAt ?? this.loggedAt,
        activityType: activityType ?? this.activityType,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        intensityLevel: intensityLevel ?? this.intensityLevel,
        postExertionMalaise: postExertionMalaise ?? this.postExertionMalaise,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
