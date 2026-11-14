class FoodEntry {
  final String id;
  final DateTime loggedAt;
  final String mealType;
  final String description;
  final String? photoPath;
  final String? postMealFeel;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FoodEntry({
    required this.id,
    required this.loggedAt,
    required this.mealType,
    required this.description,
    this.photoPath,
    this.postMealFeel,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'logged_at': loggedAt.millisecondsSinceEpoch,
        'meal_type': mealType,
        'description': description,
        'photo_path': photoPath,
        'post_meal_feel': postMealFeel,
        'note': note,
        'created_at': createdAt.millisecondsSinceEpoch,
        'updated_at': updatedAt.millisecondsSinceEpoch,
      };

  factory FoodEntry.fromMap(Map<String, dynamic> map) => FoodEntry(
        id: map['id'] as String,
        loggedAt:
            DateTime.fromMillisecondsSinceEpoch(map['logged_at'] as int),
        mealType: map['meal_type'] as String,
        description: map['description'] as String,
        photoPath: map['photo_path'] as String?,
        postMealFeel: map['post_meal_feel'] as String?,
        note: map['note'] as String?,
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
        updatedAt:
            DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      );

  FoodEntry copyWith({
    String? id,
    DateTime? loggedAt,
    String? mealType,
    String? description,
    String? photoPath,
    String? postMealFeel,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      FoodEntry(
        id: id ?? this.id,
        loggedAt: loggedAt ?? this.loggedAt,
        mealType: mealType ?? this.mealType,
        description: description ?? this.description,
        photoPath: photoPath ?? this.photoPath,
        postMealFeel: postMealFeel ?? this.postMealFeel,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
