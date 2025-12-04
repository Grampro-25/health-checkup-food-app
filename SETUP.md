# Health Checkup Food App - Setup Guide

## Quick Start

Follow these steps to get the app running on your local machine.

### Step 1: Prerequisites

Make sure you have installed:
- Flutter SDK (3.0+): https://flutter.dev/docs/get-started/install
- Android Studio or VS Code with Flutter extensions
- Xcode (for iOS development, macOS only)
- Git

### Step 2: Clone and Install

```bash
# Clone the repository
git clone https://github.com/yourusername/health-checkup-food-app.git
cd health-checkup-food-app

# Install dependencies
flutter pub get
```

### Step 3: Firebase Setup

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com/
   - Click "Add project"
   - Follow the setup wizard

2. **Add Android App**
   - In Firebase Console, click "Add app" and select Android
   - Package name: `com.healthcheckup.foodapp`
   - Download `google-services.json`
   - Place it in `android/app/`

3. **Add iOS App**
   - In Firebase Console, click "Add app" and select iOS
   - Bundle ID: `com.healthcheckup.foodapp`
   - Download `GoogleService-Info.plist`
   - Place it in `ios/Runner/`

4. **Enable Firebase Services**
   - Authentication: Enable Email/Password and Google Sign-In
   - Firestore Database: Create in production mode
   - Cloud Storage: Set up for user data
   - Cloud Messaging: Enable for push notifications

5. **Update Firebase Config**
   - Open `lib/core/config/firebase_options.dart`
   - Replace placeholder values with your Firebase credentials

### Step 4: Run the App

```bash
# Check connected devices
flutter devices

# Run on connected device
flutter run

# Run in release mode
flutter run --release
```

## API Integration (Optional)

To enable full food database functionality, sign up for these free APIs:

1. **USDA FoodData Central** (Free)
   - Sign up: https://fdc.nal.usda.gov/api-key-signup.html
   - Add your API key to the app configuration

2. **Open Food Facts** (Free, no API key needed)
   - Documentation: https://world.openfoodfacts.org/data

3. **Edamam Nutrition API** (Free tier available)
   - Sign up: https://developer.edamam.com/
   - Add your API key and App ID

## Troubleshooting

### Issue: "Package doesn't exist"
```bash
flutter clean
flutter pub get
```

### Issue: "Gradle build failed" (Android)
- Update Android SDK to latest version
- Ensure `android/local.properties` has correct SDK path

### Issue: "Pod install failed" (iOS)
```bash
cd ios
pod deintegrate
pod install
cd ..
```

### Issue: Firebase not connecting
- Verify `google-services.json` and `GoogleService-Info.plist` are in correct locations
- Ensure package/bundle IDs match Firebase configuration

## Next Steps

After successful setup:

1. **Test core features**: Login, food scanning, medication reminders
2. **Customize theme**: Edit `lib/core/theme/app_theme.dart`
3. **Add your AI models**: Place models in `assets/models/`
4. **Configure notifications**: Test on real devices
5. **Enable health integrations**: Set up Google Fit and Apple Health

## Development Tips

- Use `flutter run --hot-reload` for faster development
- Run `flutter analyze` to check for code issues
- Test on both Android and iOS devices
- Use Firebase Emulator Suite for local testing

## Getting Help

- Check the README.md for detailed documentation
- Review code comments for implementation details
- Search existing issues on GitHub
- Contact support: support@yourapp.com

Happy coding! 🚀
