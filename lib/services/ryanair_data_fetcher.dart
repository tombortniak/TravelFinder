import 'package:travel_finder/models/flight_details.dart';
import 'package:travel_finder/services/http_client.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/ryanair_data.dart';
import 'package:intl/intl.dart';
import 'package:travel_finder/constants.dart';

class RyanairDataFetcher {
  //TODO Dokończyć generowanie url, pobieranie ryanairdata z url i zwracanie ryanairdata
  Future<List<Airport>> getAvailableDestinationsForAirport(
      Airport airport) async {
    HttpClient httpClient = HttpClient();
    String url = generateUrlForAirportAvailableDestinations(airport);
    var data = await httpClient.get(url);
    RyanairData ryanairData = RyanairData(data: data);
    return ryanairData.toAvailableDestinationsForAirport();
  }

  String generateUrlForAirportAvailableDestinations(Airport airport) {
    double budget = 1000;
    String dateRangeStart = DateFormat('y-M-d').format(DateTime.now());
    String dateRangeEnd = DateFormat('y-M-d').format(DateTime(
        DateTime.now().year + 1, DateTime.now().month, DateTime.now().day));
    String url =
        '$kBaseRyanairUrl$kOneWayUrl&departureAirportIataCode=${airport.iataCode}&&outboundDepartureDateFrom=$dateRangeStart&outboundDepartureDateTo=$dateRangeEnd&priceValueTo=$budget';

    return url;
  }
}
