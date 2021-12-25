import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DateRange with ChangeNotifier {
  DateTimeRange? _dateRange;

  DateTimeRange? get dateRange => _dateRange;

  void setDateTimeRange(DateTimeRange dateTimeRange) {
    _dateRange = dateTimeRange;
    notifyListeners();
  }

  void resetDateRange() {
    _dateRange = null;
    notifyListeners();
  }
}

class DateRangeText extends StatelessWidget {
  const DateRangeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<DateRange>().dateRange == null
          ? 'Data range'
          : (context.watch<DateRange>().dateRange!.start ==
                  context.watch<DateRange>().dateRange!.end
              ? '${DateFormat('EEE, MMM d').format(context.watch<DateRange>().dateRange!.start)}'
              : '${DateFormat('EEE, MMM d').format(context.watch<DateRange>().dateRange!.start)} - ${DateFormat('EEE, MMM d').format(context.watch<DateRange>().dateRange!.end)}'),
      style: context.watch<DateRange>().dateRange != null
          ? Theme.of(context).textTheme.bodyText1
          : Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
    );
  }
}
