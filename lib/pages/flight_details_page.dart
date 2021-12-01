import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/services/airports.dart';

class FlightDetailsPage extends StatefulWidget {
  static const routeName = '/flightType/flightDetails';
  final FlightType _flightType;

  FlightDetailsPage({required flightType}) : _flightType = flightType;

  @override
  State<FlightDetailsPage> createState() => _FlightDetailsPageState();
}

class _FlightDetailsPageState extends State<FlightDetailsPage> {
  AirportFinder _airportFinder = AirportFinder();
  List<Airport>? _availableAirports;

  @override
  void initState() {
    super.initState();
  }

  void getAvailableAirports() async {
    _availableAirports = await _airportFinder.getAvailableAirports();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('graphics/flights.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            title: Text(widget._flightType == FlightType.oneWay
                ? 'One way flight'
                : 'Return trip'),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Airport',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  padding: EdgeInsets.all(10.0),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Flight type',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  padding: EdgeInsets.all(5.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
