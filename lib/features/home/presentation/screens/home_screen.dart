import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardTab(),
    const FoodHistoryTab(),
    const MedicationTab(),
    const FitnessTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Food',
          ),
          NavigationDestination(
            icon: Icon(Icons.medication_outlined),
            selectedIcon: Icon(Icons.medication),
            label: 'Medication',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Fitness',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/food-scan'),
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF1A1A1A) : const Color(0xFF0F0F0F);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scan Food Section
              _buildScanFoodSection(context),
              const SizedBox(height: 20),

              // Healthy Food Suggestions
              _buildFeatureCard(
                context,
                'HEALTHY FOOD SUGGESTIONS',
                'Get personalized meal ideas based on your preferences',
                Icons.restaurant_menu,
                const Color(0xFF4CAF50),
                () => context.push('/food-scan'),
              ),
              const SizedBox(height: 16),

              // Allergy Alerts
              _buildFeatureCard(
                context,
                'ALLERGY ALERTS',
                'Receive warnings if allergens are detected',
                Icons.warning_amber_rounded,
                const Color(0xFFFF9800),
                () => context.push('/allergies'),
              ),
              const SizedBox(height: 16),

              // Pill & Medication Reminders
              _buildFeatureCard(
                context,
                'PILL & MEDICATION REMINDERS',
                'Schedule reminders for medications',
                Icons.medication,
                const Color(0xFF2196F3),
                () => context.push('/medications'),
              ),
              const SizedBox(height: 16),

              // Fitness Support
              _buildFeatureCard(
                context,
                'FITNESS SUPPORT',
                'Access workout plans and activity goals',
                Icons.directions_run,
                const Color(0xFF9C27B0),
                () => context.push('/fitness'),
              ),
              const SizedBox(height: 20),

              // Dashboard Section
              _buildDashboardSection(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanFoodSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SCAN FOOD',
            style: TextStyle(
              color: Color(0xFF64B5F6),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildScanButton(
                context,
                Icons.camera_alt,
                'Camera',
                () => context.push('/food-scan'),
              ),
              _buildScanButton(
                context,
                Icons.qr_code_scanner,
                'Barcode',
                () => context.push('/food-scan'),
              ),
              _buildScanButton(
                context,
                Icons.text_fields,
                'Text',
                () => context.push('/food-scan'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Detect ingredients and determine if the food is healthy or unhealthy.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF64B5F6),
              size: 36,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF64B5F6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DASHBOARD',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildDashboardStat(
                      Icons.filter_4,
                      'Daily scans',
                      const Color(0xFF64B5F6),
                    ),
                    const SizedBox(height: 16),
                    _buildDashboardStat(
                      Icons.remove_circle_outline,
                      'Health score',
                      const Color(0xFFFF9800),
                    ),
                    const SizedBox(height: 16),
                    _buildDashboardStat(
                      Icons.favorite,
                      'Medication reminder',
                      const Color(0xFF2196F3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: 0.72,
                          strokeWidth: 12,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFFF9800)),
                        ),
                      ),
                      const Column(
                        children: [
                          Text(
                            '72',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Health score',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardStat(IconData icon, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Placeholder tabs
class FoodHistoryTab extends StatelessWidget {
  const FoodHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Center(child: Text('Food History')),
    );
  }
}

class MedicationTab extends StatelessWidget {
  const MedicationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Center(child: Text('Medication')),
    );
  }
}

class FitnessTab extends StatelessWidget {
  const FitnessTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Center(child: Text('Fitness')),
    );
  }
}
