import 'package:travel_finder/models/flight_details.dart';
import 'package:travel_finder/services/ryanair_endpoint_url_generator.dart';
import 'package:travel_finder/services/http_client.dart';
import 'package:travel_finder/models/airport.dart';

class RyanairDataFetcher {
  Future<Map<String, dynamic>> getAvailableDestinationsForAirport(
      Airport airport) async {
    HttpClient httpClient = HttpClient();
    String url =
        RyanairEndpointUrlGenerator.generateUrlForAirportAvailableDestinations(
            airport);
    var data = await httpClient.get(url);
    return data;
  }

  Future<Map<String, dynamic>> getOneWayFlights(
      FlightDetails flightDetails) async {
    HttpClient httpClient = HttpClient();
    String url =
        RyanairEndpointUrlGenerator.generateUrlForOneWayFlights(flightDetails);
    var data = await httpClient.get(url);
    return data;
  }
}
