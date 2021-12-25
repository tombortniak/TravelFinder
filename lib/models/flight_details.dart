import 'package:travel_finder/constants.dart';
import 'airport.dart';
import 'package:flutter/material.dart';

class FlightDetails {
  final Airport _departureAirport;
  final Airport _arrivalAirport;
  final DateTimeRange _travelDateRange;
  final FlightType _flightType;
  final double _budget;

  FlightDetails(
      {required departureAirport,
      required arrivalAirport,
      required travelDateRange,
      required flightType,
      required budget})
      : _departureAirport = departureAirport,
        _arrivalAirport = arrivalAirport,
        _travelDateRange = travelDateRange,
        _flightType = flightType,
        _budget = budget;

  get departureAiport => _departureAirport;
  get arrivalAiport => _arrivalAirport;
  get travelDateRange => _travelDateRange;
  get flightType => _flightType;
  get budget => _budget;
}
