import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';

class DepartureAirport with ChangeNotifier {
  String _value = 'Departure airport';

  String get value => _value;

  void setAirport(Airport airport) {
    _value = airport.name;
    notifyListeners();
  }
}

class DepartureAirportText extends StatelessWidget {
  const DepartureAirportText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<DepartureAirport>().value,
      style: TextStyle(
        color: context.watch<DepartureAirport>().value == 'Departure airport'
            ? Colors.grey
            : Colors.black,
      ),
    );
  }
}
