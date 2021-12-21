import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_finder/constants.dart';
import 'package:intl/intl.dart';
import 'package:travel_finder/components/button.dart';
import 'package:travel_finder/components/month_card.dart';

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

  List<Widget> generateMonthContainers() {
    DateTime currentDate = DateTime.now();

    int monthCounter = 0;

    List<Widget> columnChildren = [];
    while (monthCounter < 12) {
      List<Widget> rowChildren = [];
      for (int i = 0; i < 3; ++i) {
        var container = Expanded(
          child: MonthCard(currentDate: currentDate),
        );
        rowChildren.add(container);
        currentDate = DateTime(currentDate.year, currentDate.month + 1);
      }
      columnChildren.add(Row(children: rowChildren));
      monthCounter += 3;
    }

    return columnChildren;
  }

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
                          child: Text('$month $year'),
                        );
                      }),
                      availableCalendarFormats: {_calendarFormat: 'month'},
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text('Month'),
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          Column(
                            children: generateMonthContainers(),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Container(
                            child: Text('Period'),
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          Wrap(
                            spacing: 20.0,
                            runSpacing: 10.0,
                            alignment: WrapAlignment.center,
                            children: [
                              PeriodCard(
                                text: 'Next 3 months',
                              ),
                              PeriodCard(
                                text: 'Next 6 months',
                              ),
                              PeriodCard(
                                text: 'Next year',
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Button(
                    text: 'Confirm',
                    textColor: Colors.white,
                    backgroundColor: Colors.blue,
                    onPressed: () {},
                  ),
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PeriodCard extends StatelessWidget {
  final String _text;

  PeriodCard({required text}) : _text = text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _text,
      ),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
