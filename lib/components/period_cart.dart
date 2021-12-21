import 'package:flutter/material.dart';
import 'package:travel_finder/models/date_range.dart';
import 'package:provider/provider.dart';

class PeriodCard extends StatefulWidget {
  final String _text;
  final DateTimeRange _dateTimeRange;

  PeriodCard({required text, required dateTimeRange})
      : _text = text,
        _dateTimeRange = dateTimeRange;

  @override
  State<PeriodCard> createState() => _PeriodCardState();
}

class _PeriodCardState extends State<PeriodCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          child: Text(
            widget._text,
            style: TextStyle(
              color:
                  context.watch<DateRange>().dateRange == widget._dateTimeRange
                      ? Colors.white
                      : Colors.black,
            ),
          ),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: context.watch<DateRange>().dateRange == widget._dateTimeRange
                ? Colors.blue
                : Colors.white,
            border: Border.all(
                color: context.watch<DateRange>().dateRange ==
                        widget._dateTimeRange
                    ? Colors.white
                    : Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () {
          context.read<DateRange>().setDateTimeRange(widget._dateTimeRange);
        });
  }
}
