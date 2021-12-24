import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';

class DepartureAirport with ChangeNotifier {
  Airport? _airport;

  Airport? get airport => _airport;

  void setAirport(Airport airport) {
    _airport = airport;
    notifyListeners();
  }

  void resetAirport() {
    _airport = null;
    notifyListeners();
  }
}

class DepartureAirportText extends StatelessWidget {
  const DepartureAirportText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<DepartureAirport>().airport == null
          ? 'Departure airport'
          : context.watch<DepartureAirport>().airport!.name,
      style: context.watch<DepartureAirport>().airport != null
          ? Theme.of(context).textTheme.bodyText1
          : Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
    );
  }
}
