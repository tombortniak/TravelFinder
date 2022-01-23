import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/flight.dart';
import 'package:travel_finder/models/flight_details.dart';

abstract class FlightsWebApi {
  Future<Map<String, dynamic>> fetchData(String url);
  Future<List<Flight>> fetchOneWayFlightsPerDay(FlightDetails flightDetails);
  Future<List<Flight>> fetchCheapestOneWayFlights(FlightDetails flightDetails);
  Future<List<Flight>> fetchCheapestRoundTripFlights(
      FlightDetails flightDetails);
  Future<List<Airport>> fetchAvailableDestinations(Airport airport);
}
