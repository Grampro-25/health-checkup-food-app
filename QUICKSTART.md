# Quick Setup Instructions

## What I've Added

I've created all necessary Android and iOS configuration files to get your app running:

### Android Files Created:
- ✅ MainActivity.kt (with Flutter v2 embedding)
- ✅ build.gradle (app and project level)
- ✅ gradle.properties
- ✅ styles.xml (light and dark themes)
- ✅ launch_background.xml
- ✅ Temporary google-services.json (placeholder)

### iOS Files Created:
- ✅ AppDelegate.swift
- ✅ Podfile (with iOS 13.0 minimum)
- ✅ Placeholder for GoogleService-Info.plist

## Next Steps to Run the App

### 1. Replace Firebase Configuration Files

**For Android:**
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create/select your project
3. Add an Android app with package name: `com.healthcheckup.foodapp`
4. Download `google-services.json`
5. Replace the file at: `android/app/google-services.json`

**For iOS:**
1. In Firebase Console, add an iOS app
2. Bundle ID: `com.healthcheckup.foodapp`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

### 2. Update Firebase Options

Edit `lib/core/config/firebase_options.dart` with your actual Firebase credentials from the Firebase Console.

### 3. Run the App

```powershell
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# For iOS (macOS only) - install pods
cd ios
pod install
cd ..

# Run the app
flutter run
```

## If You Get Errors

### Android:
- Ensure you have Android SDK installed
- Make sure `google-services.json` is valid
- Run: `flutter clean && flutter pub get`

### iOS (macOS only):
- Ensure Xcode is installed
- Run: `cd ios && pod install && cd ..`
- Make sure `GoogleService-Info.plist` is added to Xcode project

## Test Without Firebase (Quick Test)

If you want to test the UI without Firebase:
1. Comment out Firebase initialization in `lib/main.dart`
2. Comment out Firebase imports
3. Run `flutter run`

This will let you see the UI and navigate through screens.

## Current Status

✅ All Android configuration files created
✅ All iOS configuration files created
✅ Temporary Firebase config added (needs replacement)
✅ Flutter v2 embedding configured
✅ Material 3 support enabled
✅ All permissions configured

The app is ready to build once you add your Firebase configuration files!
