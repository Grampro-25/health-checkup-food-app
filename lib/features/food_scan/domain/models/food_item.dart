class FoodItem {
  final String id;
  final String name;
  final String? imageUrl;
  final List<String> ingredients;
  final NutritionalInfo nutritionalInfo;
  final double healthScore;
  final HealthStatus healthStatus;
  final List<String> allergens;
  final String? barcode;
  final DateTime scannedAt;

  FoodItem({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.ingredients,
    required this.nutritionalInfo,
    required this.healthScore,
    required this.healthStatus,
    required this.allergens,
    this.barcode,
    required this.scannedAt,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      ingredients: List<String>.from(json['ingredients'] as List),
      nutritionalInfo: NutritionalInfo.fromJson(json['nutritionalInfo'] as Map<String, dynamic>),
      healthScore: (json['healthScore'] as num).toDouble(),
      healthStatus: HealthStatus.values.firstWhere(
        (e) => e.toString() == 'HealthStatus.${json['healthStatus']}',
      ),
      allergens: List<String>.from(json['allergens'] as List),
      barcode: json['barcode'] as String?,
      scannedAt: DateTime.parse(json['scannedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'nutritionalInfo': nutritionalInfo.toJson(),
      'healthScore': healthScore,
      'healthStatus': healthStatus.toString().split('.').last,
      'allergens': allergens,
      'barcode': barcode,
      'scannedAt': scannedAt.toIso8601String(),
    };
  }
}

class NutritionalInfo {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fats;
  final double fiber;
  final double sugar;
  final double sodium;
  final double cholesterol;
  final String servingSize;

  NutritionalInfo({
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.cholesterol,
    required this.servingSize,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbohydrates: (json['carbohydrates'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
      sodium: (json['sodium'] as num).toDouble(),
      cholesterol: (json['cholesterol'] as num).toDouble(),
      servingSize: json['servingSize'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fats': fats,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'cholesterol': cholesterol,
      'servingSize': servingSize,
    };
  }
}

enum HealthStatus {
  healthy,
  moderate,
  unhealthy,
}

class HealthyAlternative {
  final String name;
  final String reason;
  final double healthScore;
  final String? imageUrl;

  HealthyAlternative({
    required this.name,
    required this.reason,
    required this.healthScore,
    this.imageUrl,
  });

  factory HealthyAlternative.fromJson(Map<String, dynamic> json) {
    return HealthyAlternative(
      name: json['name'] as String,
      reason: json['reason'] as String,
      healthScore: (json['healthScore'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'reason': reason,
      'healthScore': healthScore,
      'imageUrl': imageUrl,
    };
  }
}
