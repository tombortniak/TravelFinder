import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_finder/constants.dart';
import 'package:intl/intl.dart';

class DateSelectionPage extends StatefulWidget {
  DateSelectionPage({Key? key}) : super(key: key);

  @override
  State<DateSelectionPage> createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.enforced;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: AppBar(
                  title: Text('Dates'),
                  bottom: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: 'Exact date',
                      ),
                      Tab(
                        text: 'Flexible dates',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: TabBarView(
                  children: [
                    TableCalendar(
                      firstDay: kCalendarFirstDay,
                      lastDay: kCalendarEndDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      rangeSelectionMode: _rangeSelectionMode,
                      calendarFormat: _calendarFormat,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = selectedDay;
                          _rangeStart = null;
                          _rangeEnd = null;
                          _rangeSelectionMode = RangeSelectionMode.toggledOff;
                        });
                      },
                      onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          _selectedDay = null;
                          _focusedDay = focusedDay;
                          _rangeStart = start;
                          _rangeEnd = end;
                          _rangeSelectionMode = RangeSelectionMode.toggledOn;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                          todayBuilder: (context, selectedDay, focusedDay) {
                        final text = DateFormat.d().format(selectedDay);
                        return Center(
                          child: Container(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.black),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(10.0),
                          ),
                        );
                      }, headerTitleBuilder: (context, day) {
                        final month = DateFormat.MMMM().format(day);
                        final year = DateFormat.y().format(day);
                        return Center(
                          child: Text(month + ' ' + year),
                        );
                      }),
                      availableCalendarFormats: {_calendarFormat: 'month'},
                    ),
                    TableCalendar(
                      firstDay: kCalendarFirstDay,
                      lastDay: kCalendarEndDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      rangeSelectionMode: _rangeSelectionMode,
                      calendarFormat: _calendarFormat,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = selectedDay;
                          _rangeStart = null;
                          _rangeEnd = null;
                          _rangeSelectionMode = RangeSelectionMode.toggledOff;
                        });
                      },
                      onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          _selectedDay = null;
                          _focusedDay = focusedDay;
                          _rangeStart = start;
                          _rangeEnd = end;
                          _rangeSelectionMode = RangeSelectionMode.toggledOn;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                          todayBuilder: (context, selectedDay, focusedDay) {
                        final text = DateFormat.d().format(selectedDay);
                        return Center(
                          child: Container(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.black),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(10.0),
                          ),
                        );
                      }, headerTitleBuilder: (context, day) {
                        final month = DateFormat.MMMM().format(day);
                        final year = DateFormat.y().format(day);
                        return Center(
                          child: Text(month + ' ' + year),
                        );
                      }),
                      availableCalendarFormats: {_calendarFormat: 'month'},
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
