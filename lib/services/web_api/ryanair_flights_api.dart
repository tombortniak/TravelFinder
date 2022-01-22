import 'dart:convert';

import 'package:travel_finder/models/flight.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:travel_finder/services/web_api/flights_web_api.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/fare.dart';
import 'package:travel_finder/services/ryanair_api_url_generator.dart';
import 'package:http/http.dart' as http;

class RyanairFlightsApi implements FlightsWebApi {
  Future<Map<String, dynamic>> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    return data;
  }

  Future<List<Airport>> fetchAvailableDestinations(Airport airport) async {
    final String url =
        RyanairApiUrlGenerator.urlForAirportAvailableDestinations(airport);
    final data = await fetchData(url);

    List<Airport> airports = [];
    for (var fare in data['fares']) {
      final ryanairFare = Fare.fromJson(fare);
      final airport = ryanairFare.outboundFlight.arrivalAirport;
      airports.add(airport);
    }
    return airports;
  }

  Future<List<Flight>> fetchOneWayFlights(FlightDetails flightDetails) async {
    final String url =
        RyanairApiUrlGenerator.urlForOneWayFlightsPerDay(flightDetails);
    final data = await fetchData(url);
    List<Flight> flights = [];

    for (var fare in data['fares']) {
      final ryanairFare = Fare.fromJson(fare);
      final flight = ryanairFare.outboundFlight;
      flights.add(flight);
    }
    return flights;
  }

  Future<List<Flight>> fetchCheapestOneWayFlights(
      FlightDetails flightDetails) async {
    final String url =
        RyanairApiUrlGenerator.urlForCheapestOneWayFlights(flightDetails);
    final data = await fetchData(url);
    List<Flight> flights = [];

    for (var fare in data['fares']) {
      final ryanairFare = Fare.fromJson(fare);
      final flight = ryanairFare.outboundFlight;
      flights.add(flight);
    }
    return flights;
  }

  Future<List<Flight>> fetchCheapestRoundTripFlights(
      FlightDetails flightDetails) async {
    final String url =
        RyanairApiUrlGenerator.urlForCheapestRoundTripFlights(flightDetails);
    final data = await fetchData(url);
    List<Flight> flights = [];

    for (var fare in data['fares']) {
      final ryanairFare = Fare.fromJson(fare);
      final flight = ryanairFare.outboundFlight;
      flights.add(flight);
    }
    return flights;
  }
}
