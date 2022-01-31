import 'dart:convert';

import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';

class ExerciseData {
  int? id;
  ExerciseLog exerciseLog;

  ExerciseData({
    required this.id,
    required this.exerciseLog,
  });
}
