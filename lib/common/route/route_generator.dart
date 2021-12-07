import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/common/route/routes.dart';
import 'package:ivse1_gymlife/feature/calender/ui/calendar_overview.dart';
import 'package:ivse1_gymlife/feature/workout/ui/workout.dart';
import 'package:ivse1_gymlife/feature/workout_category/ui/exercise_picker.dart';
import 'package:ivse1_gymlife/feature/workout_category/ui/workout_category.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case Routes.landing:
        return MaterialPageRoute<dynamic>(builder: (_) => Calendar());
      case Routes.workout:
        return MaterialPageRoute<dynamic>(
            builder: (_) => WorkoutPage()); // TODO give workoutlog
      case Routes.workoutcategory:
        return MaterialPageRoute<dynamic>(
            builder: (_) => WorkoutCategoryScreen());
      case Routes.exercisepicker:
        return MaterialPageRoute<dynamic>(
            builder: (_) => ExercisePicker());
      default:
        return MaterialPageRoute<dynamic>(builder: (_) => Calendar());
    }
  }
}
