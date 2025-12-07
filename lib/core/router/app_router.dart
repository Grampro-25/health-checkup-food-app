import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_checkup_food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:health_checkup_food_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:health_checkup_food_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:health_checkup_food_app/features/home/presentation/screens/home_screen.dart';
import 'package:health_checkup_food_app/features/food_scan/presentation/screens/food_scan_screen.dart';
import 'package:health_checkup_food_app/features/food_scan/presentation/screens/food_details_screen.dart';
import 'package:health_checkup_food_app/features/allergies/presentation/screens/allergy_management_screen.dart';
import 'package:health_checkup_food_app/features/medication/presentation/screens/medication_list_screen.dart';
import 'package:health_checkup_food_app/features/medication/presentation/screens/add_medication_screen.dart';
import 'package:health_checkup_food_app/features/fitness/presentation/screens/fitness_dashboard_screen.dart';
import 'package:health_checkup_food_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:health_checkup_food_app/features/profile/presentation/screens/settings_screen.dart';
import 'package:health_checkup_food_app/features/auth/presentation/providers/auth_providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/onboarding',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
                         state.matchedLocation == '/signup' ||
                         state.matchedLocation == '/onboarding';

      // If user is not authenticated and trying to access protected route
      if (!isAuthenticated && !isAuthRoute) {
        return '/login';
      }

      // If user is authenticated and trying to access auth routes
      if (isAuthenticated && isAuthRoute && state.matchedLocation != '/onboarding') {
        return '/';
      }

      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),

      // Home Routes
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Food Scan Routes
      GoRoute(
        path: '/food-scan',
        name: 'food-scan',
        builder: (context, state) => const FoodScanScreen(),
      ),
      GoRoute(
        path: '/food-details/:id',
        name: 'food-details',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FoodDetailsScreen(foodId: id);
        },
      ),

      // Allergy Routes
      GoRoute(
        path: '/allergies',
        name: 'allergies',
        builder: (context, state) => const AllergyManagementScreen(),
      ),

      // Medication Routes
      GoRoute(
        path: '/medications',
        name: 'medications',
        builder: (context, state) => const MedicationListScreen(),
      ),
      GoRoute(
        path: '/medications/add',
        name: 'add-medication',
        builder: (context, state) => const AddMedicationScreen(),
      ),

      // Fitness Routes
      GoRoute(
        path: '/fitness',
        name: 'fitness',
        builder: (context, state) => const FitnessDashboardScreen(),
      ),

      // Profile Routes
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
});
