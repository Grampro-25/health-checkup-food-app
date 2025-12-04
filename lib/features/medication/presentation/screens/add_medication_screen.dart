import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _instructionsController = TextEditingController();
  
  String _frequency = 'Once daily';
  final List<TimeOfDay> _reminderTimes = [const TimeOfDay(hour: 9, minute: 0)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medication'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medication Name *',
                  prefixIcon: Icon(Icons.medication),
                  hintText: 'e.g., Vitamin D',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medication name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage *',
                  prefixIcon: Icon(Icons.local_pharmacy),
                  hintText: 'e.g., 1000 IU',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dosage';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _frequency,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                  prefixIcon: Icon(Icons.repeat),
                ),
                items: const [
                  DropdownMenuItem(value: 'Once daily', child: Text('Once daily')),
                  DropdownMenuItem(value: 'Twice daily', child: Text('Twice daily')),
                  DropdownMenuItem(value: 'Three times daily', child: Text('Three times daily')),
                  DropdownMenuItem(value: 'Every other day', child: Text('Every other day')),
                  DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                  DropdownMenuItem(value: 'As needed', child: Text('As needed')),
                ],
                onChanged: (value) {
                  setState(() {
                    _frequency = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Reminder Times',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ..._reminderTimes.asMap().entries.map((entry) {
                final index = entry.key;
                final time = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.alarm),
                    title: Text(time.format(context)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        if (_reminderTimes.length > 1) {
                          setState(() {
                            _reminderTimes.removeAt(index);
                          });
                        }
                      },
                    ),
                    onTap: () => _selectTime(index),
                  ),
                );
              }),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _reminderTimes.add(const TimeOfDay(hour: 9, minute: 0));
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Another Time'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Instructions (Optional)',
                  prefixIcon: Icon(Icons.note),
                  hintText: 'e.g., Take with food',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveMedication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Medication'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTimes[index],
    );
    if (picked != null) {
      setState(() {
        _reminderTimes[index] = picked;
      });
    }
  }

  void _saveMedication() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medication saved successfully')),
      );
      context.pop();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }
}
