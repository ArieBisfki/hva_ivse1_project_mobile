enum ExerciseType { chest, back, legs }

String getExerciseName(ExerciseType type) {
  switch (type) {
    case ExerciseType.chest:
      return 'Chest';
      break;
    case ExerciseType.back:
      return 'Back';
      break;
    case ExerciseType.legs:
      return 'Legs';
      break;
    default:
      return 'All';
      break;
  }
}

class Exercise {
  final int id;
  final int category;
  final String name;
  final ExerciseType exerciseType;

  Exercise({
    required this.id,
    required this.category,
    required this.name,
    required this.exerciseType,
  });
}
