import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:health_checkup_food_app/core/config/firebase_options.dart';
import 'package:health_checkup_food_app/core/services/notification_service.dart';
import 'package:health_checkup_food_app/core/router/app_router.dart';
import 'package:health_checkup_food_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize timezone for notifications
  tz.initializeTimeZones();

  // Initialize notification service
  await NotificationService().initialize();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: HealthCheckupApp()));
}

class HealthCheckupApp extends ConsumerWidget {
  const HealthCheckupApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Health Checkup Food App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
