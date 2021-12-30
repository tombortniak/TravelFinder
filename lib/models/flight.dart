import 'package:intl/intl.dart';
import 'package:travel_finder/models/airport.dart';

class Flight {
  final Airport departureAirport;
  final Airport arrivalAirport;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;
  final double ticketPrice;

  Flight(
      {required this.departureAirport,
      required this.arrivalAirport,
      required this.departureDateTime,
      required this.arrivalDateTime,
      required this.ticketPrice});

  factory Flight.fromJson(Map<String, dynamic> data) {
    final departureAirport = Airport.fromJson(data['departureAirport']);
    final arrivalAirport = Airport.fromJson(data['arrivalAirport']);
    final departureDateTime = DateTime.parse(data['departureDate']);
    final arrivalDateTime = DateTime.parse(data['arrivalDate']);
    final ticketPrice = data['price']['value'] as double;

    return Flight(
        departureAirport: departureAirport,
        arrivalAirport: arrivalAirport,
        departureDateTime: departureDateTime,
        arrivalDateTime: arrivalDateTime,
        ticketPrice: ticketPrice);
  }
}
