import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/common/route/routes.dart';
import 'package:ivse1_gymlife/feature/calender/models/login_info.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/ui/calendar_overview.dart';
import 'package:ivse1_gymlife/feature/login/models/login_creds_response_E.dart';
import 'package:ivse1_gymlife/feature/login/models/login_response_S.dart';
import 'package:ivse1_gymlife/feature/login/recources/login_api.dart';
import 'package:ivse1_gymlife/feature/login/ui/forgot_password.dart';
import 'package:ivse1_gymlife/feature/login/ui/login_screen.dart';
import 'package:ivse1_gymlife/feature/login/ui/signup_screen.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/ui/add_workout.dart';
import 'package:ivse1_gymlife/feature/workout/ui/workout.dart';
import 'package:ivse1_gymlife/feature/workout_category/ui/exercise_picker.dart';

class RouteGenerator {
  static _authGuard() async {
    return true;

    // TODO
    /*
      wordt al aangeroepen bij start
      wordt ook aangeroepen bij niet ingelogde users
    */

    //final RealApi api = new RealApi();

    // final Either<LoginCredsResponseE, LoginResponseS> loginResponse =
    //     await api.loginWithRefreshToken();
    // if (api.responseIsError(loginResponse)) {
    //   return false;
    // } else {
    //   return true;
    // }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;
    //_authGuard().then((succes) {
    //  if (succes) {
    switch (settings.name) {
      case Routes.landing:
        return MaterialPageRoute<dynamic>(
            // this bool changes a few widgets in the screen
            builder: (_) => Calendar(
                loginInfo: args is LoginInfo
                    ? args
                    : LoginInfo(loggenIn: false, ready: false)));
      case Routes.workout:
        return MaterialPageRoute<dynamic>(
            // give empty workoutLog in case a user selects a non-existing workout
            builder: (_) => WorkoutPage(
                  workoutLog: args is WorkoutLog
                      ? args
                      : WorkoutLog(
                          exerciseLogs: [],
                          id: 0,
                          date: "",
                        ),
                  exerciseData: ExerciseData(
                    id: 0,
                    exerciseLog: ExerciseLog(
                      exercise: Exercise(
                          id: 0,
                          category: 0,
                          name: "",
                          description: "",
                          image: "",
                          sets: 0,
                          reps: 0,
                          weight: 0),
                    ),
                  ),
                ));
      case Routes.add_workout:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AddWorkout(
            exerciseData: args is ExerciseData
                ? args
                : ExerciseData(
                    id: 0,
                    exerciseLog: ExerciseLog(
                      exercise: Exercise(
                          id: 0,
                          category: 0,
                          name: "",
                          description: "",
                          image: "",
                          sets: 0,
                          reps: 0,
                          weight: 0),
                    ),
                  ),
          ),
        );
      case Routes.exercisepicker:
        return MaterialPageRoute<dynamic>(builder: (_) => ExercisePicker());
      case Routes.login:
        return MaterialPageRoute<dynamic>(builder: (_) => LoginScreen());
      case Routes.signup:
        return MaterialPageRoute<dynamic>(builder: (_) => SignUpScreen());
      case Routes.forgotpassword:
        return MaterialPageRoute<dynamic>(
            builder: (_) => ForgotPasswordScreen());
      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) =>
                Calendar(loginInfo: LoginInfo(loggenIn: false, ready: false)));
    }
    // } else {
    //   return MaterialPageRoute<dynamic>(builder: (_) => LoginScreen());
    // }
    //});
    // this should never happen
    return MaterialPageRoute<dynamic>(builder: (_) => LoginScreen());
  }
}
