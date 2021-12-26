import 'package:travel_finder/constants.dart';
import 'airport.dart';
import 'package:flutter/material.dart';

class FlightDetails with ChangeNotifier {
  Airport? _departureAirport;
  Airport? _arrivalAirport;
  DateTimeRange? _travelDateRange;
  FlightType _flightType = FlightType.oneWay;
  double _budget = 150;

  Airport? get departureAirport => _departureAirport;

  set departureAirport(Airport? value) {
    _departureAirport = value;
    notifyListeners();
  }

  Airport? get arrivalAirport => _arrivalAirport;

  set arrivalAirport(Airport? value) {
    _arrivalAirport = value;
    notifyListeners();
  }

  DateTimeRange? get travelDateRange => _travelDateRange;

  set travelDateRange(DateTimeRange? value) {
    _travelDateRange = value;
    notifyListeners();
  }

  FlightType get flightType => _flightType;

  set flightType(FlightType value) {
    _flightType = value;
    notifyListeners();
  }

  double get budget => _budget;

  set budget(double value) {
    _budget = value;
    notifyListeners();
  }

  void resetAll() {
    _departureAirport = null;
    _arrivalAirport = null;
    _travelDateRange = null;
    _flightType = FlightType.oneWay;
    _budget = 150;
    notifyListeners();
  }
}
