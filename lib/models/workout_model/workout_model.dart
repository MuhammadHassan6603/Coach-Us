class WorkoutModel {
  final String id;
  final String name;
  final String description;
  final String duration;
  final int exercises;
  final String equipment;
  final String difficulty;
  final List<WorkoutStep> steps;
  final String category;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.exercises,
    required this.equipment,
    required this.difficulty,
    required this.steps,
    required this.category,
  });

  factory WorkoutModel.fromMap(Map<String, dynamic> map, String docId) {
    List<WorkoutStep> stepsList = [];
    if (map['steps'] != null) {
      stepsList = List<WorkoutStep>.from(
        (map['steps'] as List).map(
          (step) => WorkoutStep.fromMap(step),
        ),
      );
    }

    return WorkoutModel(
      id: docId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? '',
      exercises: map['exercises'] ?? 0,
      equipment: map['equipment'] ?? '',
      difficulty: map['difficulty'] ?? '',
      steps: stepsList,
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      'exercises': exercises,
      'equipment': equipment,
      'difficulty': difficulty,
      'steps': steps.map((step) => step.toMap()).toList(),
      'category': category,
    };
  }
}

class WorkoutStep {
  final String title;
  final String description;
  final int durationSeconds;
  final String? imageUrl;

  WorkoutStep({
    required this.title,
    required this.description,
    required this.durationSeconds,
    this.imageUrl,
  });

  factory WorkoutStep.fromMap(Map<String, dynamic> map) {
    return WorkoutStep(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      durationSeconds: map['durationSeconds'] ?? 0,
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'durationSeconds': durationSeconds,
      'imageUrl': imageUrl,
    };
  }
}

