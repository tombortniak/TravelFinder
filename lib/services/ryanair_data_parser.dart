import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/fare.dart';

class RyanairDataParser {
  static List<Airport> parseToAvailableDestinations(Map<String, dynamic> data) {
    List<Airport> airports = [];
    for (var fare in data['fares']) {
      final ryanairFare = Fare.fromJson(fare);
      final airport = ryanairFare.outboundFlight.arrivalAirport;
      airports.add(airport);
    }
    return airports;
  }
}
