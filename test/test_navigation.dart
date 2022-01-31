import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/calender/models/login_info.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/ui/calendar_overview.dart';
import 'package:ivse1_gymlife/feature/calender/ui/workoutLogs_overview.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/ui/workout.dart';
import 'package:mockito/mockito.dart';

class TestObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('navigation should work', (WidgetTester tester) async {
    final mockObserver = TestObserver();
    await tester.pumpWidget(
      MaterialApp(
        home: Calendar(
          loginInfo: LoginInfo(loggenIn: false, ready: false),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byType(WorkoutLogsOverview), findsOneWidget);
    await tester.tap(find.byType(WorkoutLogsOverview));
    await tester.pumpAndSettle();

    /// Verify that a push event happened
    verify(mockObserver.didPush(
        MaterialPageRoute<dynamic>(
            builder: (_) => WorkoutPage(
                  workoutLog: WorkoutLog(exerciseLogs: [], id: 0, date: ""),
                  exerciseData: ExerciseData(
                      id: 0,
                      exerciseLog: ExerciseLog(
                          exercise: Exercise(
                              id: 0,
                              category: 0,
                              name: "",
                              sets: 0,
                              reps: 0,
                              weight: 0,
                              image: "",
                              description: ""))),
                )),
        any));

    expect(find.byType(WorkoutPage), findsOneWidget);
  });
}
