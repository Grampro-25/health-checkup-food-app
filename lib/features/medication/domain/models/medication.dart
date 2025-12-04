class Medication {
  final String id;
  final String name;
  final String dosage;
  final String frequency;
  final List<DateTime> reminderTimes;
  final DateTime startDate;
  final DateTime? endDate;
  final String? instructions;
  final String? prescribedBy;
  final bool isActive;
  final List<MedicationLog> logs;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.reminderTimes,
    required this.startDate,
    this.endDate,
    this.instructions,
    this.prescribedBy,
    this.isActive = true,
    this.logs = const [],
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] as String,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      reminderTimes: (json['reminderTimes'] as List)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      instructions: json['instructions'] as String?,
      prescribedBy: json['prescribedBy'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      logs: json['logs'] != null
          ? (json['logs'] as List).map((e) => MedicationLog.fromJson(e as Map<String, dynamic>)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'reminderTimes': reminderTimes.map((e) => e.toIso8601String()).toList(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'instructions': instructions,
      'prescribedBy': prescribedBy,
      'isActive': isActive,
      'logs': logs.map((e) => e.toJson()).toList(),
    };
  }

  Medication copyWith({
    String? id,
    String? name,
    String? dosage,
    String? frequency,
    List<DateTime>? reminderTimes,
    DateTime? startDate,
    DateTime? endDate,
    String? instructions,
    String? prescribedBy,
    bool? isActive,
    List<MedicationLog>? logs,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      instructions: instructions ?? this.instructions,
      prescribedBy: prescribedBy ?? this.prescribedBy,
      isActive: isActive ?? this.isActive,
      logs: logs ?? this.logs,
    );
  }
}

class MedicationLog {
  final String id;
  final DateTime scheduledTime;
  final DateTime? takenTime;
  final bool wasTaken;
  final String? notes;

  MedicationLog({
    required this.id,
    required this.scheduledTime,
    this.takenTime,
    required this.wasTaken,
    this.notes,
  });

  factory MedicationLog.fromJson(Map<String, dynamic> json) {
    return MedicationLog(
      id: json['id'] as String,
      scheduledTime: DateTime.parse(json['scheduledTime'] as String),
      takenTime: json['takenTime'] != null ? DateTime.parse(json['takenTime'] as String) : null,
      wasTaken: json['wasTaken'] as bool,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduledTime': scheduledTime.toIso8601String(),
      'takenTime': takenTime?.toIso8601String(),
      'wasTaken': wasTaken,
      'notes': notes,
    };
  }
}
