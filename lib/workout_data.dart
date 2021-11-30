import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';

final List<Map<String, dynamic>> workout = [
  {
    'leading': ['images/bench.jpg', '10 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/deadlift.jpg', '15 x'],
    'title': 'Deadlift',
    'subtitle': '00:45',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/bench.jpg', '6 x'],
    'title': 'Bench press1',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/deadlift.jpg', '1 x'],
    'title': 'Deadlift2',
    'subtitle': '00:45',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/bench.jpg', '1 x'],
    'title': 'Bench press2',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/deadlift.jpg', '2 x'],
    'title': 'Deadlift2',
    'subtitle': '00:45',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/bench.jpg', '1 x'],
    'title': 'Bench press3',
    'subtitle': 'Yes',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/deadlift.jpg', '2 x'],
    'title': 'Deadlift3',
    'subtitle': 'No',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/bench.jpg', '12 x'],
    'title': 'Random',
    'subtitle': 'Yes',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
  {
    'leading': ['images/bench.jpg', '12 x'],
    'title': 'Testdata',
    'subtitle': 'No',
    'trailing': Icon(Icons.chevron_right, size: 25),
  },
];

final List<Map<String, dynamic>> chestWorkout = [
  {
    'leading': ['images/bench.jpg', '10 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.chest,
  },
  {
    'leading': ['images/bench.jpg', '11 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.chest,
  },
  {
    'leading': ['images/bench.jpg', '12 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.chest,
  },

];

final List<Map<String, dynamic>> legWorkout = [
  {
    'leading': ['images/bench.jpg', '10 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.legs,
  },
  {
    'leading': ['images/deadlift.jpg', '11 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.legs,
  },
  {
    'leading': ['images/bench.jpg', '12 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.legs,
  },

];

final List<Map<String, dynamic>> backWorkout = [
  {
    'leading': ['images/deadlift.jpg', '10 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.back,
  },
  {
    'leading': ['images/deadlift.jpg', '11 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.back,
  },
  {
    'leading': ['images/deadlift.jpg', '12 x'],
    'title': 'Bench press',
    'subtitle': 'subtitle',
    'trailing': Icon(Icons.chevron_right, size: 25),
    'exerciseType' : ExerciseType.back,
  },

];

