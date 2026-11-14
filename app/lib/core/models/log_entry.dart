import 'dart:convert';

class LogEntry {
  final String id;
  final DateTime loggedAt;
  final int score;
  final List<String> symptoms;
  final double? sleepHours;
  final int? stressLevel;
  final String? note;
  final bool isLowEnergyMode;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LogEntry({
    required this.id,
    required this.loggedAt,
    required this.score,
    required this.symptoms,
    this.sleepHours,
    this.stressLevel,
    this.note,
    this.isLowEnergyMode = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'logged_at': loggedAt.millisecondsSinceEpoch,
        'score': score,
        'symptoms': jsonEncode(symptoms),
        'sleep_hours': sleepHours,
        'stress_level': stressLevel,
        'note': note,
        'is_low_energy_mode': isLowEnergyMode ? 1 : 0,
        'created_at': createdAt.millisecondsSinceEpoch,
        'updated_at': updatedAt.millisecondsSinceEpoch,
      };

  factory LogEntry.fromMap(Map<String, dynamic> map) => LogEntry(
        id: map['id'] as String,
        loggedAt:
            DateTime.fromMillisecondsSinceEpoch(map['logged_at'] as int),
        score: map['score'] as int,
        symptoms: List<String>.from(
            jsonDecode(map['symptoms'] as String? ?? '[]')),
        sleepHours: map['sleep_hours'] as double?,
        stressLevel: map['stress_level'] as int?,
        note: map['note'] as String?,
        isLowEnergyMode: (map['is_low_energy_mode'] as int? ?? 0) == 1,
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
        updatedAt:
            DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      );

  LogEntry copyWith({
    String? id,
    DateTime? loggedAt,
    int? score,
    List<String>? symptoms,
    double? sleepHours,
    int? stressLevel,
    String? note,
    bool? isLowEnergyMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      LogEntry(
        id: id ?? this.id,
        loggedAt: loggedAt ?? this.loggedAt,
        score: score ?? this.score,
        symptoms: symptoms ?? this.symptoms,
        sleepHours: sleepHours ?? this.sleepHours,
        stressLevel: stressLevel ?? this.stressLevel,
        note: note ?? this.note,
        isLowEnergyMode: isLowEnergyMode ?? this.isLowEnergyMode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
