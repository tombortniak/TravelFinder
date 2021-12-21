import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel_finder/models/date_range.dart';

class MonthCard extends StatefulWidget {
  final DateTimeRange _monthRange;

  MonthCard({required monthRange}) : _monthRange = monthRange;

  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60.0,
        child: widget._monthRange.start.year == DateTime.now().year
            ? Center(
                child: Text(
                  DateFormat.MMMM().format(
                    DateTime(0, widget._monthRange.start.month),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: context.watch<DateRange>().dateRange ==
                              widget._monthRange
                          ? Colors.white
                          : Colors.black),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.MMMM().format(
                      DateTime(0, widget._monthRange.start.month),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13.0,
                        color: context.watch<DateRange>().dateRange ==
                                widget._monthRange
                            ? Colors.white
                            : Colors.black),
                  ),
                  Text(
                    widget._monthRange.start.year.toString(),
                    style: TextStyle(
                        color: context.watch<DateRange>().dateRange ==
                                widget._monthRange
                            ? Colors.white
                            : Colors.black),
                  ),
                ],
              ),
        decoration: BoxDecoration(
          color: context.watch<DateRange>().dateRange == widget._monthRange
              ? Colors.blue
              : Colors.white,
          border: Border.all(
              color: context.watch<DateRange>().dateRange == widget._monthRange
                  ? Colors.white
                  : Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      ),
      onTap: () {
        context.read<DateRange>().setDateTimeRange(widget._monthRange);
      },
    );
  }
}
