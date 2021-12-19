import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';

class AvailableDestinations with ChangeNotifier {
  List<Airport>? _availableDestinations;

  get availableDestinations => _availableDestinations ?? <Airport>[];

  void setAvailableDestinations(List<Airport> airports) {
    _availableDestinations = airports;
  }
}
