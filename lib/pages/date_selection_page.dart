import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_finder/constants.dart';
import 'package:intl/intl.dart';
import 'package:travel_finder/components/button.dart';
import 'package:provider/provider.dart';
import 'package:travel_finder/models/flight_details.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: AppBar(
                  bottom: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    tabs: [
                      Tab(
                        text: 'Dates',
                      ),
                      Tab(
                        text: 'Flexible',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: TabBarView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            headerStyle: HeaderStyle(
                                titleTextStyle:
                                    Theme.of(context).textTheme.headline3!),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = selectedDay;
                                _rangeStart = null;
                                _rangeEnd = null;
                                _rangeSelectionMode =
                                    RangeSelectionMode.toggledOff;
                              });
                            },
                            onRangeSelected: (start, end, focusedDay) {
                              setState(() {
                                _selectedDay = null;
                                _focusedDay = focusedDay;
                                _rangeStart = start;
                                _rangeEnd = end;
                                _rangeSelectionMode =
                                    RangeSelectionMode.toggledOn;
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
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent),
                                    ),
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                );
                              },
                              headerTitleBuilder: (context, day) {
                                final month = DateFormat.MMMM().format(day);
                                final year = DateFormat.y().format(day);
                                return Center(
                                  child: Text('$month $year'),
                                );
                              },
                            ),
                            availableCalendarFormats: {
                              _calendarFormat: 'month'
                            },
                          ),
                          Container(
                            child: Button(
                              text: 'Confirm',
                              textColor: Colors.white,
                              backgroundColor: Colors.blue,
                              onPressed: () {
                                if (_rangeStart != null) {
                                  _rangeEnd ??= _rangeStart;
                                  context
                                          .read<FlightDetails>()
                                          .travelDateRange =
                                      DateTimeRange(
                                          start: _rangeStart!, end: _rangeEnd!);

                                  Navigator.pop(context);
                                }
                              },
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 30.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
