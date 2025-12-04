class UserProfile {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final List<String> allergies;
  final DietaryPreference dietaryPreference;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final HealthGoals? healthGoals;

  UserProfile({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.allergies = const [],
    this.dietaryPreference = DietaryPreference.none,
    required this.createdAt,
    this.updatedAt,
    this.healthGoals,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      allergies: json['allergies'] != null ? List<String>.from(json['allergies'] as List) : [],
      dietaryPreference: DietaryPreference.values.firstWhere(
        (e) => e.toString() == 'DietaryPreference.${json['dietaryPreference']}',
        orElse: () => DietaryPreference.none,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
      healthGoals: json['healthGoals'] != null
          ? HealthGoals.fromJson(json['healthGoals'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'allergies': allergies,
      'dietaryPreference': dietaryPreference.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'healthGoals': healthGoals?.toJson(),
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    List<String>? allergies,
    DietaryPreference? dietaryPreference,
    DateTime? createdAt,
    DateTime? updatedAt,
    HealthGoals? healthGoals,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      allergies: allergies ?? this.allergies,
      dietaryPreference: dietaryPreference ?? this.dietaryPreference,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      healthGoals: healthGoals ?? this.healthGoals,
    );
  }
}

enum DietaryPreference {
  none,
  vegan,
  vegetarian,
  glutenFree,
  dairyFree,
  lowCarb,
  lowSodium,
  keto,
  paleo,
}

class HealthGoals {
  final double? targetCalories;
  final double? targetProtein;
  final double? targetCarbs;
  final double? targetFats;
  final int? dailyWaterIntake;
  final int? weeklyWorkoutGoal;
  final double? targetWeight;

  HealthGoals({
    this.targetCalories,
    this.targetProtein,
    this.targetCarbs,
    this.targetFats,
    this.dailyWaterIntake,
    this.weeklyWorkoutGoal,
    this.targetWeight,
  });

  factory HealthGoals.fromJson(Map<String, dynamic> json) {
    return HealthGoals(
      targetCalories: json['targetCalories'] != null ? (json['targetCalories'] as num).toDouble() : null,
      targetProtein: json['targetProtein'] != null ? (json['targetProtein'] as num).toDouble() : null,
      targetCarbs: json['targetCarbs'] != null ? (json['targetCarbs'] as num).toDouble() : null,
      targetFats: json['targetFats'] != null ? (json['targetFats'] as num).toDouble() : null,
      dailyWaterIntake: json['dailyWaterIntake'] as int?,
      weeklyWorkoutGoal: json['weeklyWorkoutGoal'] as int?,
      targetWeight: json['targetWeight'] != null ? (json['targetWeight'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetCalories': targetCalories,
      'targetProtein': targetProtein,
      'targetCarbs': targetCarbs,
      'targetFats': targetFats,
      'dailyWaterIntake': dailyWaterIntake,
      'weeklyWorkoutGoal': weeklyWorkoutGoal,
      'targetWeight': targetWeight,
    };
  }
}
