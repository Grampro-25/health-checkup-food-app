# Health Check-Up Food App

A comprehensive cross-platform mobile application for Android and iOS that helps users make healthier food choices through AI-powered food analysis, medication management, fitness tracking, and allergy monitoring.

## Features

### 🍎 Food Health Analysis
- **Multi-Method Scanning**: Camera, barcode scanner, or manual text entry
- **AI-Powered Detection**: Automatic ingredient recognition and analysis
- **Comprehensive Nutrition Info**: Calories, macros, vitamins, and minerals
- **Health Scoring**: Intelligent health score calculation (0-100)
- **Instant Results**: Fast food analysis with detailed breakdowns

### 🌱 Healthy Food Suggestions
- **Smart Alternatives**: AI-recommended healthier food options
- **Personalized Recommendations**: Based on dietary preferences
- **Dietary Support**: Vegan, vegetarian, low-carb, keto, gluten-free, and more
- **Meal Planning**: Personalized meal suggestions
- **Grocery Tips**: Smart shopping recommendations

### ⚠️ Allergy Alerts
- **Custom Allergy Management**: Add and manage personal allergies
- **Real-Time Warnings**: Instant pop-up alerts when scanning allergen-containing foods
- **Common Allergens**: Pre-configured database of common allergens
- **Safe Alternatives**: Suggestions for allergen-free alternatives
- **Cross-Contamination Warnings**: Detailed allergen information

### 💊 Pill & Medication Reminders
- **Smart Scheduling**: Set reminders with custom dosage and timing
- **Push Notifications**: Cross-platform notifications for both Android and iOS
- **Medication History**: Track medication intake history
- **Multiple Reminders**: Support for multiple daily medications
- **Dosage Tracking**: Monitor adherence and missed doses

### 🏃 Fitness Support
- **Personalized Workout Plans**: Custom fitness routines based on goals
- **Activity Tracking**: Steps, calories burned, and active minutes
- **Daily Goals**: Set and track fitness objectives
- **Progress Visualization**: Charts and graphs for tracking progress
- **Motivational Notifications**: Stay encouraged with timely reminders
- **Health Integration**: Optional sync with Google Fit and Apple Health

### 🎨 Modern UI/UX
- **Clean Design**: Intuitive and easy-to-navigate interface
- **Comprehensive Dashboard**: View all health metrics at a glance
- **Dark Mode**: Full dark mode support for comfortable viewing
- **Smooth Animations**: Fluid transitions and interactions
- **Fast Performance**: Optimized for quick loading and responsiveness

## Technology Stack

- **Framework**: Flutter 3.x (Cross-platform for Android & iOS)
- **Language**: Dart
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Backend**: Firebase (Authentication, Firestore, Storage, Cloud Messaging)
- **Local Storage**: Hive & SQLite
- **AI/ML**: TensorFlow Lite, Google ML Kit
- **Camera**: Camera plugin with image processing
- **Charts**: FL Chart for data visualization
- **Notifications**: Flutter Local Notifications with timezone support
- **Health Integration**: Health plugin for Google Fit & Apple Health

## Project Structure

```
lib/
├── core/
│   ├── config/
│   │   └── firebase_options.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── services/
│   │   └── notification_service.dart
│   └── theme/
│       └── app_theme.dart
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       └── screens/
│   │           ├── login_screen.dart
│   │           ├── signup_screen.dart
│   │           └── onboarding_screen.dart
│   ├── home/
│   │   └── presentation/
│   │       └── screens/
│   │           └── home_screen.dart
│   ├── food_scan/
│   │   ├── domain/
│   │   │   └── models/
│   │   │       └── food_item.dart
│   │   └── presentation/
│   │       └── screens/
│   │           ├── food_scan_screen.dart
│   │           └── food_details_screen.dart
│   ├── allergies/
│   │   └── presentation/
│   │       └── screens/
│   │           └── allergy_management_screen.dart
│   ├── medication/
│   │   ├── domain/
│   │   │   └── models/
│   │   │       └── medication.dart
│   │   └── presentation/
│   │       └── screens/
│   │           ├── medication_list_screen.dart
│   │           └── add_medication_screen.dart
│   ├── fitness/
│   │   └── presentation/
│   │       └── screens/
│   │           └── fitness_dashboard_screen.dart
│   └── profile/
│       ├── domain/
│       │   └── models/
│       │       └── user_profile.dart
│       └── presentation/
│           └── screens/
│               ├── profile_screen.dart
│               └── settings_screen.dart
└── main.dart
```

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: 3.0 or higher
- **Dart SDK**: 3.0 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development, macOS only)
- **CocoaPods** (for iOS dependencies)
- **Firebase Account**: For backend services

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/health-checkup-food-app.git
cd health-checkup-food-app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### Android:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Add an Android app to your project
4. Download `google-services.json`
5. Place it in `android/app/`

#### iOS:
1. In Firebase Console, add an iOS app
2. Download `GoogleService-Info.plist`
3. Place it in `ios/Runner/`

#### Configure Firebase Options:
Update `lib/core/config/firebase_options.dart` with your Firebase credentials.

### 4. Platform-Specific Setup

#### Android (`android/app/build.gradle`):
```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

#### iOS (`ios/Podfile`):
```ruby
platform :ios, '13.0'
```

### 5. Permissions

#### Android (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION"/>
```

#### iOS (`ios/Runner/Info.plist`):
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to scan food items</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access to analyze food images</string>
<key>NSHealthShareUsageDescription</key>
<string>We need access to read your health data</string>
<key>NSHealthUpdateUsageDescription</key>
<string>We need access to update your health data</string>
```

## Running the App

### Development Mode

```bash
# Run on Android
flutter run

# Run on iOS (macOS only)
flutter run

# Run on specific device
flutter run -d <device_id>

# List available devices
flutter devices
```

### Build for Production

#### Android APK:
```bash
flutter build apk --release
```

#### Android App Bundle:
```bash
flutter build appbundle --release
```

#### iOS:
```bash
flutter build ios --release
```

## Configuration

### AI Food Recognition

The app uses TensorFlow Lite models for food recognition. To use custom models:

1. Place your `.tflite` model files in `assets/models/`
2. Update model references in the food scanning service
3. Ensure model input/output dimensions match your preprocessing

### API Integration

For nutritional data and food databases, you can integrate:

- **USDA FoodData Central API**
- **Open Food Facts API**
- **Edamam Nutrition API**

Update API keys in your environment configuration.

## Features in Detail

### Dashboard
- Daily health score visualization
- Recent food scans overview
- Upcoming medication reminders
- Today's fitness summary
- Quick access to all features
- Daily health tips

### Food Scanning
- **Camera Mode**: Real-time food recognition
- **Barcode Mode**: Instant product lookup
- **Text Entry Mode**: Manual food entry
- Detailed nutritional breakdown
- Health score calculation
- Ingredient analysis
- Allergen warnings

### Medication Management
- Add multiple medications
- Set custom reminder times
- Track medication history
- Mark doses as taken/missed
- View adherence statistics

### Fitness Tracking
- Daily step counter
- Calorie tracking
- Workout recommendations
- Progress charts
- Goal setting and tracking
- Integration with health platforms

## Security & Privacy

- **Data Encryption**: All sensitive data encrypted at rest
- **Secure Authentication**: Firebase Authentication with email/password and OAuth
- **HIPAA Compliance Ready**: Architecture supports healthcare data protection
- **Local Storage**: Sensitive data stored locally with encryption
- **Privacy Controls**: User control over data sharing and permissions

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## Deployment

### Android (Google Play Store)
1. Create a keystore
2. Configure signing in `android/app/build.gradle`
3. Build the app bundle: `flutter build appbundle --release`
4. Upload to Google Play Console

### iOS (App Store)
1. Configure signing in Xcode
2. Build for release: `flutter build ios --release`
3. Archive and upload via Xcode or Transporter

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## Troubleshooting

### Common Issues

**Camera not working:**
- Ensure camera permissions are granted
- Check that camera is not being used by another app

**Notifications not appearing:**
- Verify notification permissions
- Check notification settings in device settings
- Ensure Firebase Cloud Messaging is configured

**Build failures:**
- Run `flutter clean`
- Delete `pubspec.lock` and run `flutter pub get`
- Update Flutter: `flutter upgrade`

## Roadmap

- [ ] Meal planning with calendar integration
- [ ] Social features (share progress, challenges)
- [ ] Integration with more fitness trackers
- [ ] AR food visualization
- [ ] Voice commands
- [ ] Apple Watch & Wear OS apps
- [ ] Recipe suggestions based on available ingredients
- [ ] Restaurant menu scanning
- [ ] Water intake tracking
- [ ] Sleep tracking integration

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend infrastructure
- TensorFlow team for ML capabilities
- All open-source contributors

## Contact

- **Developer**: Your Name
- **Email**: your.email@example.com
- **Website**: https://yourwebsite.com
- **Support**: support@yourapp.com

## Screenshots

_Add screenshots of your app here_

---

**Made with ❤️ using Flutter**
