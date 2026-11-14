class PeriodEntry {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final String flowLevel;
  final String painLevel;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PeriodEntry({
    required this.id,
    required this.startDate,
    this.endDate,
    this.flowLevel = '未记录',
    this.painLevel = '未记录',
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isOngoing => endDate == null;

  Map<String, dynamic> toMap() => {
        'id': id,
        'start_date': startDate.millisecondsSinceEpoch,
        'end_date': endDate?.millisecondsSinceEpoch,
        'flow_level': flowLevel,
        'pain_level': painLevel,
        'note': note,
        'created_at': createdAt.millisecondsSinceEpoch,
        'updated_at': updatedAt.millisecondsSinceEpoch,
      };

  factory PeriodEntry.fromMap(Map<String, dynamic> map) => PeriodEntry(
        id: map['id'] as String,
        startDate:
            DateTime.fromMillisecondsSinceEpoch(map['start_date'] as int),
        endDate: map['end_date'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['end_date'] as int),
        flowLevel: map['flow_level'] as String? ?? '未记录',
        painLevel: map['pain_level'] as String? ?? '未记录',
        note: map['note'] as String?,
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
        updatedAt:
            DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      );

  PeriodEntry copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    String? flowLevel,
    String? painLevel,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PeriodEntry(
        id: id ?? this.id,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        flowLevel: flowLevel ?? this.flowLevel,
        painLevel: painLevel ?? this.painLevel,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
