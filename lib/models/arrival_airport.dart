import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';

class ArrivalAirport with ChangeNotifier {
  String _value = 'Arrival airport';

  String get value => _value;

  void setAirport(Airport airport) {
    _value = airport.name;
    notifyListeners();
  }
}

class ArrivalAirportText extends StatelessWidget {
  const ArrivalAirportText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<ArrivalAirport>().value,
      style: TextStyle(
        color: context.watch<ArrivalAirport>().value == 'Arrival airport'
            ? Colors.grey
            : Colors.black,
      ),
    );
  }
}
