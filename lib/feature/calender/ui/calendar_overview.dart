import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();

  Map<DateTime, List<Event>> selectedEvents = {};

  @override
  initState() {
    selectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Add workout'),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[_selectedDay] != null) {
                      selectedEvents[_selectedDay]!.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      // selectedEvents[_selectedDay] = [
                      //   Event(title: _eventController.text)
                      // ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
              TextButton(
                  child: Text('CANCEL'),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GymLife calendar'),
      ),
      body: Center(
        child: Column(children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            eventLoader: _getEventsfromDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          ..._getEventsfromDay(_selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
