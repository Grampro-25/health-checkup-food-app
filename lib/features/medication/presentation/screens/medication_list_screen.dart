import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MedicationListScreen extends StatelessWidget {
  const MedicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMedicationCard(
            context,
            'Vitamin D',
            '1000 IU',
            'Once daily',
            ['09:00 AM'],
            true,
          ),
          const SizedBox(height: 12),
          _buildMedicationCard(
            context,
            'Omega-3',
            '1200 mg',
            'Twice daily',
            ['08:00 AM', '08:00 PM'],
            true,
          ),
          const SizedBox(height: 12),
          _buildMedicationCard(
            context,
            'Multivitamin',
            '1 tablet',
            'Once daily',
            ['09:00 AM'],
            false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/medications/add'),
        backgroundColor: const Color(0xFF2196F3),
        icon: const Icon(Icons.add),
        label: const Text('Add Medication'),
      ),
    );
  }

  Widget _buildMedicationCard(
    BuildContext context,
    String name,
    String dosage,
    String frequency,
    List<String> times,
    bool isActive,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dosage,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFE8F5E9) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: isActive ? const Color(0xFF4CAF50) : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  frequency,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: times.map((time) {
                return Chip(
                  label: Text(time),
                  avatar: const Icon(Icons.alarm, size: 16),
                  backgroundColor: const Color(0xFFE3F2FD),
                  labelStyle: const TextStyle(fontSize: 12),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.history, size: 16),
                  label: const Text('History'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
