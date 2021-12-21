import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';

class ArrivalAirport with ChangeNotifier {
  Airport? _airport;

  Airport get airport =>
      _airport ??
      Airport(
          name: 'Arrival airport',
          country: 'None',
          countryAlpha2Code: 'None',
          iataCode: 'None');

  void setAirport(Airport airport) {
    _airport = airport;
    notifyListeners();
  }

  void clearAirport() {
    _airport = null;
    notifyListeners();
  }
}

class ArrivalAirportText extends StatelessWidget {
  const ArrivalAirportText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<ArrivalAirport>().airport.name,
      style: TextStyle(
        color: context.watch<ArrivalAirport>().airport.name == 'Arrival airport'
            ? Colors.grey
            : Colors.black,
      ),
    );
  }
}
