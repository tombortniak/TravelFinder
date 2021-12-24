import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';

class ArrivalAirport with ChangeNotifier {
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

class ArrivalAirportText extends StatelessWidget {
  const ArrivalAirportText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<ArrivalAirport>().airport == null
          ? 'Arrival airport'
          : context.watch<ArrivalAirport>().airport!.name,
      style: context.watch<ArrivalAirport>().airport != null
          ? Theme.of(context).textTheme.bodyText1
          : Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
    );
  }
}
