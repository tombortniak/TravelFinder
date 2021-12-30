import 'package:flutter/material.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:travel_finder/models/flight.dart';
import 'package:travel_finder/services/ryanair_data_fetcher.dart';

class FlightSearchResultsPage extends StatefulWidget {
  final FlightDetails _flightDetails;

  FlightSearchResultsPage({required flightDetails})
      : _flightDetails = flightDetails;

  @override
  State<FlightSearchResultsPage> createState() =>
      _FlightSearchResultsPageState();
}

class _FlightSearchResultsPageState extends State<FlightSearchResultsPage> {
  RyanairDataFetcher ryanairDataFetcher = RyanairDataFetcher();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
