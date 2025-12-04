import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF4CAF50),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'john.doe@email.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('152', 'Food Scans', Icons.restaurant),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('28', 'Days Active', Icons.calendar_today),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Profile Options
            _buildProfileOption(
              context,
              'Health Goals',
              Icons.track_changes,
              () {},
            ),
            _buildProfileOption(
              context,
              'Dietary Preferences',
              Icons.restaurant_menu,
              () {},
            ),
            _buildProfileOption(
              context,
              'Allergies',
              Icons.warning_amber_rounded,
              () => context.push('/allergies'),
            ),
            _buildProfileOption(
              context,
              'Medication History',
              Icons.medication,
              () => context.push('/medications'),
            ),
            _buildProfileOption(
              context,
              'Activity History',
              Icons.history,
              () {},
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildProfileOption(
              context,
              'Help & Support',
              Icons.help_outline,
              () {},
            ),
            _buildProfileOption(
              context,
              'Privacy Policy',
              Icons.privacy_tip_outlined,
              () {},
            ),
            _buildProfileOption(
              context,
              'Terms of Service',
              Icons.description_outlined,
              () {},
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF44336),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.logout, color: Color(0xFFF44336)),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFFF44336)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFF44336)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF4CAF50), size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4CAF50)),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
