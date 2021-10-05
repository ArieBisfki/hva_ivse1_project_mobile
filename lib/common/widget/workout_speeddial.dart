import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class WorkoutSpeeddial extends StatelessWidget {
  void onTapDial() {}

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 3,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      buttonSize: 56,
      iconTheme: IconThemeData(size: 22),
      childrenButtonSize: 56.0,
      direction: SpeedDialDirection.up,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      isOpenOnStart: false,
      animationSpeed: 200,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.accessibility),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          label: 'Weights',
          onTap: () => debugPrint("FIRST CHILD"),
        ),
        SpeedDialChild(
          child: const Icon(Icons.accessible_sharp),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          label: 'Crossfit',
          onTap: () => {onTapDial()},
        ),
        SpeedDialChild(
          child: const Icon(Icons.person),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          label: 'Cardio',
          visible: true,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(("Third Child Pressed")))),
        ),
      ],
    );
  }
}
