import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DateRange with ChangeNotifier {
  DateTimeRange? _dateRange;

  DateTimeRange? get dateRange => _dateRange;

  void setDateTimeRange(DateTimeRange dateTimeRange) {
    _dateRange = dateTimeRange;
    notifyListeners();
  }

  void clearDateRange() {
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
          : context.watch<DateRange>().dateRange.toString(),
      style: TextStyle(
        color: context.watch<DateRange>().dateRange == null
            ? Colors.grey
            : Colors.black,
      ),
    );
  }
}
