import 'package:flutter/material.dart';

class AllergyManagementScreen extends StatefulWidget {
  const AllergyManagementScreen({super.key});

  @override
  State<AllergyManagementScreen> createState() =>
      _AllergyManagementScreenState();
}

class _AllergyManagementScreenState extends State<AllergyManagementScreen> {
  final List<String> _allergies = ['Peanuts', 'Dairy', 'Gluten'];
  final TextEditingController _allergyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allergy Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFFFFF3E0),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xFFFF9800),
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Add your known allergies to get real-time alerts when scanning food items.',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your Allergies',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            if (_allergies.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No allergies added yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _allergies.map((allergy) {
                  return Chip(
                    label: Text(allergy),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _allergies.remove(allergy);
                      });
                    },
                    backgroundColor: const Color(0xFFFFEBEE),
                    labelStyle: const TextStyle(color: Color(0xFFF44336)),
                  );
                }).toList(),
              ),
            const SizedBox(height: 24),
            Text(
              'Add New Allergy',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _allergyController,
                    decoration: const InputDecoration(
                      labelText: 'Allergy Name',
                      hintText: 'e.g., Shellfish',
                      prefixIcon: Icon(Icons.warning_amber_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  onPressed: _addAllergy,
                  backgroundColor: const Color(0xFFFF9800),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Common Allergies',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Peanuts',
                'Tree Nuts',
                'Milk',
                'Eggs',
                'Soy',
                'Wheat',
                'Fish',
                'Shellfish',
                'Sesame',
              ].map((allergy) {
                final isAdded = _allergies.contains(allergy);
                return FilterChip(
                  label: Text(allergy),
                  selected: isAdded,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _allergies.add(allergy);
                      } else {
                        _allergies.remove(allergy);
                      }
                    });
                  },
                  selectedColor: const Color(0xFFFFEBEE),
                  checkmarkColor: const Color(0xFFF44336),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _addAllergy() {
    final allergy = _allergyController.text.trim();
    if (allergy.isNotEmpty && !_allergies.contains(allergy)) {
      setState(() {
        _allergies.add(allergy);
        _allergyController.clear();
      });
    }
  }

  @override
  void dispose() {
    _allergyController.dispose();
    super.dispose();
  }
}
