import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/models/flight.dart';

class FlightsCalendarPage extends StatefulWidget {
  final Flight _flight;

  FlightsCalendarPage({required flight}) : _flight = flight;

  @override
  State<FlightsCalendarPage> createState() => _FlightsCalendarPageState();
}

class _FlightsCalendarPageState extends State<FlightsCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: kCalendarFirstDay,
            lastDay: kCalendarEndDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders:
                CalendarBuilders(markerBuilder: (context, day, events) {
              return Container();
            }),
          )
        ],
      ),
    ));
  }
}
