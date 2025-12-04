import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_checkup_food_app/core/theme/app_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _medicationReminders = true;
  bool _fitnessReminders = true;
  bool _hydrationReminders = true;

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Light Mode'),
                  value: ThemeMode.light,
                  groupValue: currentThemeMode,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).state = value!;
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Dark Mode'),
                  value: ThemeMode.dark,
                  groupValue: currentThemeMode,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).state = value!;
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('System Default'),
                  value: ThemeMode.system,
                  groupValue: currentThemeMode,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).state = value!;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Notifications',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Enable Notifications'),
                  subtitle: const Text('Receive all app notifications'),
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Medication Reminders'),
                  value: _medicationReminders,
                  onChanged: _notificationsEnabled
                      ? (value) {
                          setState(() {
                            _medicationReminders = value;
                          });
                        }
                      : null,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Fitness Reminders'),
                  value: _fitnessReminders,
                  onChanged: _notificationsEnabled
                      ? (value) {
                          setState(() {
                            _fitnessReminders = value;
                          });
                        }
                      : null,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Hydration Reminders'),
                  value: _hydrationReminders,
                  onChanged: _notificationsEnabled
                      ? (value) {
                          setState(() {
                            _hydrationReminders = value;
                          });
                        }
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Data & Privacy',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Export Data'),
                  subtitle: const Text('Download your health data'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_forever),
                  title: const Text('Delete Account'),
                  subtitle: const Text('Permanently delete your account'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                          'Are you sure you want to delete your account? This action cannot be undone.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF44336),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'About',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Version'),
                  trailing: Text(
                    '1.0.0',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Terms of Service'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Licenses'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showLicensePage(context: context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
