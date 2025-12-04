# Health Checkup Food App - API Documentation

## Overview

This document describes the backend API structure and how to integrate external APIs for food data, nutrition analysis, and health tracking.

## Backend Architecture

The app uses Firebase as the primary backend with the following services:

### Firebase Services

#### 1. Authentication
- Email/Password authentication
- Google OAuth
- User profile management

#### 2. Firestore Database

**Collections:**

```
users/
  {userId}/
    - email: string
    - displayName: string
    - allergies: array<string>
    - dietaryPreference: string
    - createdAt: timestamp
    - healthGoals: map

foodScans/
  {scanId}/
    - userId: string
    - name: string
    - imageUrl: string
    - ingredients: array<string>
    - nutritionalInfo: map
    - healthScore: number
    - allergens: array<string>
    - scannedAt: timestamp

medications/
  {medicationId}/
    - userId: string
    - name: string
    - dosage: string
    - frequency: string
    - reminderTimes: array<timestamp>
    - startDate: timestamp
    - endDate: timestamp
    - isActive: boolean
    - logs: array<map>

fitnessActivities/
  {activityId}/
    - userId: string
    - type: string
    - duration: number
    - caloriesBurned: number
    - date: timestamp
```

## External API Integration

### 1. USDA FoodData Central API

**Purpose**: Comprehensive nutritional data

**Endpoint**: `https://api.nal.usda.gov/fdc/v1/`

**Authentication**: API Key

**Example Request:**
```dart
Future<Map<String, dynamic>> searchFood(String query) async {
  final response = await http.get(
    Uri.parse('https://api.nal.usda.gov/fdc/v1/foods/search?query=$query&api_key=YOUR_API_KEY'),
  );
  return json.decode(response.body);
}
```

**Response Format:**
```json
{
  "foods": [
    {
      "fdcId": 123456,
      "description": "Apple",
      "brandOwner": "Generic",
      "foodNutrients": [
        {
          "nutrientName": "Protein",
          "value": 0.3,
          "unitName": "G"
        }
      ]
    }
  ]
}
```

### 2. Open Food Facts API

**Purpose**: Product barcode lookup and ingredient data

**Endpoint**: `https://world.openfoodfacts.org/api/v0/`

**Authentication**: None (Open API)

**Example Request:**
```dart
Future<Map<String, dynamic>> getProductByBarcode(String barcode) async {
  final response = await http.get(
    Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'),
  );
  return json.decode(response.body);
}
```

**Response Format:**
```json
{
  "status": 1,
  "product": {
    "product_name": "Organic Whole Milk",
    "brands": "Brand Name",
    "ingredients_text": "Organic milk",
    "nutriments": {
      "energy-kcal": 64,
      "proteins": 3.2,
      "carbohydrates": 4.8,
      "fat": 3.6
    }
  }
}
```

### 3. Edamam Nutrition Analysis API

**Purpose**: Detailed nutrition analysis from text or images

**Endpoint**: `https://api.edamam.com/api/nutrition-details`

**Authentication**: App ID and App Key

**Example Request:**
```dart
Future<Map<String, dynamic>> analyzeNutrition(String ingredientText) async {
  final response = await http.post(
    Uri.parse('https://api.edamam.com/api/nutrition-details?app_id=YOUR_APP_ID&app_key=YOUR_APP_KEY'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'title': 'Recipe',
      'ingr': [ingredientText]
    }),
  );
  return json.decode(response.body);
}
```

## AI/ML Integration

### Food Recognition Model

**Model Type**: TensorFlow Lite

**Input**: 
- Image dimensions: 224x224x3
- Format: RGB float32 normalized [0, 1]

**Output**:
- Food category predictions
- Confidence scores

**Implementation:**
```dart
import 'package:tflite_flutter/tflite_flutter.dart';

class FoodRecognitionService {
  Interpreter? _interpreter;
  
  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/models/food_classifier.tflite');
  }
  
  Future<List<dynamic>> classifyImage(List<List<List<num>>> input) async {
    var output = List.filled(1000, 0).reshape([1, 1000]);
    _interpreter?.run(input, output);
    return output;
  }
}
```

## Cloud Functions (Optional)

Deploy Firebase Cloud Functions for server-side processing:

### 1. Nutrition Analysis Function

```javascript
exports.analyzeNutrition = functions.https.onCall(async (data, context) => {
  const ingredients = data.ingredients;
  
  // Call external API
  const nutritionData = await fetchNutritionData(ingredients);
  
  // Calculate health score
  const healthScore = calculateHealthScore(nutritionData);
  
  return {
    nutritionInfo: nutritionData,
    healthScore: healthScore
  };
});
```

### 2. Allergen Detection Function

```javascript
exports.checkAllergens = functions.https.onCall(async (data, context) => {
  const userId = context.auth.uid;
  const ingredients = data.ingredients;
  
  // Get user allergies from Firestore
  const userDoc = await admin.firestore()
    .collection('users')
    .doc(userId)
    .get();
  
  const userAllergies = userDoc.data().allergies;
  
  // Check for allergens
  const foundAllergens = ingredients.filter(ingredient => 
    userAllergies.some(allergy => 
      ingredient.toLowerCase().includes(allergy.toLowerCase())
    )
  );
  
  return {
    hasAllergens: foundAllergens.length > 0,
    allergens: foundAllergens
  };
});
```

## Health Data Sync

### Google Fit Integration

```dart
import 'package:health/health.dart';

class HealthService {
  final Health _health = Health();
  
  Future<void> syncHealthData() async {
    final types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ];
    
    final permissions = types.map((type) => 
      HealthDataAccess.READ_WRITE
    ).toList();
    
    await _health.requestAuthorization(types, permissions: permissions);
    
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));
    
    List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
      yesterday,
      now,
      types,
    );
    
    // Process and store health data
  }
}
```

## Rate Limits and Best Practices

### USDA API
- Rate Limit: 1000 requests/hour
- Best Practice: Cache responses locally

### Open Food Facts
- Rate Limit: No strict limit, but be respectful
- Best Practice: Include User-Agent header

### Edamam
- Free Tier: 5 calls/min, 10,000 calls/month
- Best Practice: Batch requests when possible

## Error Handling

```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, [this.statusCode]);
  
  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

Future<T> handleApiCall<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } on SocketException {
    throw ApiException('No internet connection');
  } on HttpException {
    throw ApiException('HTTP error occurred');
  } on FormatException {
    throw ApiException('Invalid response format');
  } catch (e) {
    throw ApiException('Unexpected error: $e');
  }
}
```

## Security

### API Key Storage

Store API keys securely:

```dart
// Using flutter_secure_storage
final storage = FlutterSecureStorage();

// Store
await storage.write(key: 'api_key', value: 'YOUR_API_KEY');

// Retrieve
String? apiKey = await storage.read(key: 'api_key');
```

### Request Authentication

Always include authentication tokens:

```dart
Future<Response> makeAuthenticatedRequest(String url) async {
  final token = await FirebaseAuth.instance.currentUser?.getIdToken();
  
  return await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
}
```

## Testing

### Mock API Responses

```dart
class MockFoodApi implements FoodApiInterface {
  @override
  Future<FoodItem> searchFood(String query) async {
    await Future.delayed(Duration(seconds: 1));
    return FoodItem(
      id: '1',
      name: 'Mock Food Item',
      // ... other properties
    );
  }
}
```

## Support

For API integration issues:
- USDA: support@fdc.nal.usda.gov
- Open Food Facts: https://slack.openfoodfacts.org/
- Edamam: api@edamam.com
